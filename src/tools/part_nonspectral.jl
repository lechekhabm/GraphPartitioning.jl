# M.L. for High Performance Computing Lab @USI & @ETHZ - malik.lechekhab@usi.ch  


"""
    _partition(coords::Matrix, v::Vector)

Compute a partition based on `coords` using a direction vector `v`.

# Arguments
- `coords::Matrix`: Node coordinates in a 2D space.
- `v::Vector`: Direction vector defining the partitioning line.

# Returns
- A tuple of two vectors: indices of nodes in each partition.

# Example
```julia-repl
julia> _partition(coords, [0, 1])
([1, 2, 3, 9, 10], [4, 5, 6, 7, 8])
```
"""
function _partition(coords::Matrix, v::Vector)
    n, d = size(coords)
    
    v = v[:]
    dotprod = coords * v
    split = median(dotprod)
    a = findall(x -> x < split, dotprod)
    b = findall(x -> x > split, dotprod)
    c = findall(x -> x == split, dotprod)
    nc = length(c)
    
    if nc != 0
        na = length(a)
        nca = Int64(max(ceil(n/2)-na, 0))
        nca = Int64(min(nca, nc))

        if nca > 0
            a = [a; c[1:nca]]
        end
        if nca < nc
            b = [b; c[nca + 1: nc]]
        end
    end

    return a, b
end


"""
    part_inertial(A::SparseMatrixCSC, coords::Matrix)

Compute a bi-partition of the graph `A` using the inertial method based on `coords`.

# Arguments
- `A::SparseMatrixCSC`: Adjacency matrix of the graph.
- `coords::Matrix`: Node coordinates used for partitioning.

# Returns
- A vector of partition labels for each node.

# Example
```julia-repl
julia> part_inertial(A, coords)
 1
 ⋮
 2
```
"""
function part_inertial(A::SparseMatrixCSC, coords::Matrix)
    x = coords[:, 1]
    y = coords[:, 2]

    n = size(x)[1]

    # 1. Compute the center of mass.
    x_bar = sum(x)/n
    y_bar = sum(y)/n

    # 2. Construct the matrix M. (see pdf of the assignment)
    sxx = sum((x .- x_bar).^2)
    syy = sum((y .- y_bar).^2)
    sxy = sum((x .- x_bar).*(y .- y_bar))
    M = [[syy sxy]
        [sxy sxx]]

    # 3. Compute the eigenvector associated with the smallest eigenvalue of M.
    eig_vals, eig_vecs = eigs(M; which=:SR, ncv = 300, nev=1)

    # 4. Partition the nodes around line L 
    #    (use may use the function partition(coords, eigv))
    i = sortperm(eig_vals)
    eigv = eig_vecs[:,i]
    eigv = [eigv[1]; -eigv[2]]
    eigv = eigv./norm(eigv)
    p1, p2 = _partition(coords, eigv)
    p = ones(Int, n)
    p[p1] .= 1
    p[p2] .= 2

    # 5. Return the indicator vector
    return p

end


"""
    part_coordinate(A::SparseMatrixCSC, coords::Matrix)

Compute a bi-partition of the graph `A` using the coordinate method based on `coords`.

# Arguments
- `A::SparseMatrixCSC`: Adjacency matrix of the graph.
- `coords::Matrix`: Node coordinates used for partitioning.

# Returns
- A vector of partition labels for each node.

# Example
```julia-repl
julia> part_coordinate(A, coords)
 1
 ⋮
 2
```
"""
function  part_coordinate(A::SparseMatrixCSC, coords::Matrix)
    d = size(coords)[2]
    best_cut = Inf
    p = ones(Int, size(coords)[1])
    p_temp = ones(Int, size(coords)[1])
    for dim in 1:d
        v = zeros(d)
        v[dim] = 1
        p1, p2 = _partition(coords, v)
        p_temp[p1] .= 1
        p_temp[p2] .= 2
        this_cut = count_edge_cut(A, p_temp)
        if this_cut < best_cut
            best_cut = this_cut
            p = ones(Int, size(coords)[1])
            p[p1] .= 1
            p[p2] .= 2
        end
    end
    
    return p
end
