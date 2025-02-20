"""
    write_graph_input(A::SparseMatrixCSC; prefix::String="graph", temp::Bool=false) -> String

Generate a graph file in a format compatible with partitioning tools like KaHIP, Graclus, and MDC.

This function converts a symmetric adjacency matrix into a graph file suitable for external partitioning tools. 
The graph file follows the standard format: 
- The first line contains the number of nodes and edges. 
- Each subsequent line corresponds to a node, listing its neighbors as space-separated integers.

# Arguments
- `A::SparseMatrixCSC`: The symmetric adjacency matrix of the graph.
- `prefix::String`: Optional file name prefix when `temp=false` (default: `"graph"`).
- `temp::Bool`: If `true`, creates a temporary file that is deleted after use. If `false`, saves to `./PartitionGraphs`.

# Returns
- `String`: The file path to the generated graph file.

# Notes
- The adjacency matrix should represent an undirected graph with no self-loops. 
- Edge weights are not supported; only the structure is written.
"""
function _write_partition_input(A::SparseMatrixCSC; prefix::String="graph", temp::Bool=false)
    n_nodes = size(A, 1)
    I, J, _ = findnz(A)
    n_edges = div(length(I), 2)

    if temp
        mktemp() do file, _
            write(file, "$n_nodes $n_edges\n")

            for i in 1:n_nodes  
                neighbors = J[findall(==(i), I)]
                write(file, join(neighbors, " ") * "\n")
            end

            return file
        end
    else
        dir = "./adjacency_lists"
        mkpath(dir)
        file_path = joinpath(dir, "$prefix.graph")

        open(file_path, "w") do file
            write(file, "$n_nodes $n_edges\n")
            for i in 1:n_nodes
                neighbors = J[findall(==(i), I)]
                write(file, join(neighbors, " ") * "\n")
            end
        end

        return file_path
    end
end

"""
   _run_cmd(cmd::Cmd) -> NamedTuple

Run an external command and capture its outputs.

# Example
```julia-repl
julia> cmd = `../KaHIP/deploy/kaffpa graph.mat --k 4 --preconfiguration=fast`;
julia> result = _run_cmd(cmd)
julia> println(result.stdout)
```
"""
function _run_cmd(cmd::Cmd)
	out = Pipe()
	err = Pipe()

	process = run(pipeline(cmd, stdout=out, stderr=err), wait=false)

	close(out.in)
	close(err.in)

	stdout_task = @async String(read(out))
	stderr_task = @async String(read(err))

	wait(process)

	return (
		stdout = fetch(stdout_task),
		stderr = fetch(stderr_task),
		code = process.exitcode
	)
end

"""
    get_executable(exec_name::String) -> String

Retrieve the path of an external executable from environment variables and validate its existence.

# Arguments
- `exec_name`: Name of the environment variable storing the executable path.

# Returns
- `String`: The validated executable path.

# Errors
- Throws an error if the environment variable is not set or if the executable does not exist.

# Example Usage
```julia
graclus_exec = get_executable("GRACLUS_PATH")

"""
function _get_executable(exec_name::String)
    if !haskey(ENV, exec_name)
        error("❌ Environment variable $exec_name is not set. Please define it with the path to the executable.")
    end

    exec_path = ENV[exec_name]

    # Check if the file exists
    if !isfile(exec_path)
        error("❌ Executable '$exec_path' not found. Please check the $exec_name environment variable.")
    end

    return exec_path
end
