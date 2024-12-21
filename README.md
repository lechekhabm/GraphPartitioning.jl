# GraphPartitioning.jl

This is the code repository for ``GraphPartitioning.jl``, a toolbox for graph partitioning algorithms in Julia. It provides a framework to compare, benchmark, and analyze various graph partitioning techniques. The framework supports both non-recursive and recursive methods with geometric information, like coordinate and inertial bisection, as well as methods without geometric information, such as spectral bisection. It makes it easy to evaluate and compare the outputs of different methods, helping users understand their trade-offs and applications.

We chose Julia for its modern, user-friendly syntax, high performance, and commitment to open-source principles. This makes it an ideal language for both education and research in graph partitioning.

Graph partitioning is a fundamental problem with wide-ranging applications in scientific domains where the relationships between interconnected variables play a crucial role.
From computational biology and social network analysis to high-performance computing and distributed systems, efficient graph partitioning techniques are key to optimizing performance, reducing computational overhead, and enabling deeper insights into complex data.

<picture>
  <source srcset="assets/images/GraphPartitioning.jl_bk.png" media="(prefers-color-scheme: dark)">
  <img src="assets/images/GraphPartitioning.jl.png">
</picture>

---

## Running Unit Tests

To evaluate the functionality of different partitioning methods, execute the `test` function directly via the command line interface. This function invokes all tests defined in the test suite and provides a detailed report of the results.

### Steps:

1. Navigate to the root directory of the package:

   ```bash
   cd GraphPartitioning
   ```

2. Launch the Julia REPL and activate the package environment:

   ```bash
   julia --project=.
   ```

3. Run the tests using the following commands:

   ```julia
   using GraphPartitioning
   GraphPartitioning.test()
   ```

Executing these steps will ensure that all test cases in `/test/runtests.jl` are executed, allowing for a systematic verification of key partitioning algorithems and interfaces.

---


## Running Examples

The package includes example scripts in the `GraphPartitioning/examples/` directory. These scripts demonstrate how to use the package to benchmark and compare different graph partitioning methods.

### Example 1: Comparing Partitioning Methods

**Script:** `GraphPartitioning/examples/ex1.jl`

This example compares different graph partitioning methods, including:

- **Coordinate Bisection**
- **Inertial Bisection**
- **Spectral Bisection**
- **Bisection using METIS**

The script evaluates these methods on a series of different graphs, providing insights into their performance and effectiveness.

<!-- 2x2 Grid for Airfoil1 Examples -->
<table style="width:100%; border-collapse: collapse;">
  <tr>
    <!-- Coordinate Bisection -->
    <td style="width:50%; text-align: center; padding: 0;">
      <img src="examples/ex1_airfoil1_coordinate.png" alt="Coordinate Bisection" style="width:100%; margin:0; padding:0;">
      <p style="margin: 0; padding: 0;"><em>Coordinate Bisection</em></p>
    </td>
    <!-- Inertial Bisection -->
    <td style="width:50%; text-align: center; padding: 0;">
      <img src="examples/ex1_airfoil1_inertial.png" alt="Inertial Bisection" style="width:100%; margin:0; padding:0;">
      <p style="margin: 0; padding: 0;"><em>Inertial Bisection</em></p>
    </td>
  </tr>
  <tr>
    <!-- Spectral Bisection -->
    <td style="width:50%; text-align: center; padding: 0;">
      <img src="examples/ex1_airfoil1_spectral.png" alt="Spectral Bisection" style="width:100%; margin:0; padding:0;">
      <p style="margin: 0; padding: 0;"><em>Spectral Bisection</em></p>
    </td>
    <!-- METIS Bisection -->
    <td style="width:50%; text-align: center; padding: 0;">
      <img src="examples/ex1_airfoil1_metis.png" alt="METIS Bisection" style="width:100%; margin:0; padding:0;">
      <p style="margin: 0; padding: 0;"><em>METIS</em></p>
    </td>
  </tr>
</table>

#### How to Run Example 1

1. Navigate to the `examples` directory:

   ```bash
   cd GraphPartitioning/examples
   ```

2. Run the example script in the Julia REPL or directly from the terminal:

   ```bash
   julia ex1.jl
   ```

---

### Example 2: Recursive Bisection

**Script:** `GraphPartitioning/examples/ex2.jl`

This example demonstrates recursive bisection using different methods, including:

- **Coordinate Bisection**
- **Inertial Bisection**
- **Spectral Bisection**
- **Recursive Bisection using METIS K-way**

<table style="width:100%; border-collapse: collapse;">
  <tr>
    <!-- Recursive Coordinate Bisection -->
    <td style="width:50%; text-align: center; padding: 10px;">
      <img src="examples/ex2_Swiss_graph_coordinate.png" alt="Recursive Coordinate Bisection" style="width:100%;">
      <p style="font-size: 12px;"><em>Recursive Coordinate Bisection</em></p>
    </td>
    <!-- Recursive Inertial Bisection -->
    <td style="width:50%; text-align: center; padding: 10px;">
      <img src="examples/ex2_Swiss_graph_inertial.png" alt="Recursive Inertial Bisection" style="width:100%;">
      <p style="font-size: 12px;"><em>Recursive Inertial Bisection</em></p>
    </td>
  </tr>
  <tr>
    <!-- Recursive Spectral Bisection -->
    <td style="width:50%; text-align: center; padding: 10px;">
      <img src="examples/ex2_Swiss_graph_spectral.png" alt="Recursive Spectral Bisection" style="width:100%;">
      <p style="font-size: 12px;"><em>Recursive Spectral Bisection</em></p>
    </td>
    <!-- Recursive METIS Bisection -->
    <td style="width:50%; text-align: center; padding: 10px;">
      <img src="examples/ex2_Swiss_graph_metis_rec.png" alt="Recursive METIS Bisection" style="width:100%;">
      <p style="font-size: 12px;"><em>Recursive METIS Bisection</em></p>
    </td>
  </tr>
</table>

#### How to Run Example 2

1. Navigate to the `examples` directory:

   ```bash
   cd GraphPartitioning/examples
   ```

2. Run the example script in the Julia REPL or directly from the terminal:

   ```bash
   julia ex2.jl
   ```

---

## Notes

- Ensure that all dependencies for the package and the examples are installed. If you encounter any issues, make sure the package environment is activated, and run:

  ```julia
  using Pkg
  Pkg.instantiate()
  ```

- For detailed documentation and usage examples, refer to the official documentation (if provided) or explore the source code in the `src` directory.

---

Feel free to contribute or report issues on the GitHub repository for **GraphPartitioning.jl**. Happy partitioning!

## Publication

Please cite [XXXX](https://epubs.siam.org/doi/10.1137/21M1392231) in your publications if it helps your research:
```
@article{doi:10.1137/21M1392231,
 author = {Name},
 title = {Tile},
 journal = X},
 volume = {44},
 number = {3},
 pages = {C210-C236},
 year = {2022},
 doi = {10.1137/21M1392231}
}
```
See [here](https://arxiv.org/pdf/2202.06555.pdf) for an archived version of the article. 


### Authors
* [Aryan Eftekhari](https://scholar.google.com/citations?user=GiugKBsAAAAJ&hl=en) (Department of Economics, University of Lausanne)
* [Simon Scheidegger](https://sites.google.com/site/simonscheidegger/) (Department of Economics, University of Lausanne)


### Other Relate Resreach 
[Using Adaptive Sparse Grids to Solve High-Dimensional Dynamic Models; Brumm & Scheidegger (2017)](https://onlinelibrary.wiley.com/doi/abs/10.3982/ECTA12216)).
[Sparse Grids for Dynamic Economic Models; Brumm et al. (2022)](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3979412)(2021)
