# PROPTIMUS RAPHAN

## Description

PROPTIMUS RAPHAN is a rapid alternative to constrained alpha-carbon optimisation. This approach divides a protein structure into overlapping substructures, allowing each to be optimised independently. As a result, the computation time is linear with respect to the size of the structure. Our approach can achieve results comparable to overall structure optimisation with constrained alpha carbons in significantly less time. PROPTIMUS RAPHAN employs an almost quantum-mechanically accurate force field, [GFN-FF](https://onlinelibrary.wiley.com/doi/10.1002/anie.202004239). This force field is generic, physics-based, and suitable for large molecular systems. Methodological details are described in the [article](https://www.biorxiv.org/content/10.1101/2025.11.24.690085v2.full).

## Installation

**1. Download and run the [Miniconda](https://www.anaconda.com/docs/getting-started/miniconda/main) installer**

```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```

**2. Clone GitHub repository:**

```
git clone https://github.com/sb-ncbr/proptimus_raphan
```

**3. Set up a virtual environment**

* Create a virtual environment named `proptimus-raphan`:

```
conda env create -f proptimus_raphan/environment.yml
```

* Activate the virtual environment:

```
conda activate proptimus-raphan
```

## Executing the calculation

### Required arguments

`--PDB_file PDB_FILE`          PDB file with structure, which should be optimised.

`--data_dir DATA_DIR`          Directory for saving results.

### Optional arguments

`--cpu CPU`                                       How many CPUs should be used for the calculation.

`--delete_auxiliary_files`                        Auxiliary calculation files can be large. With this argument, the auxiliary files will be deleted during the calculation. Do not use in combination with the argument `‑‑constrained_alpha_carbons_optimisations`!

`--constrained_alpha_carbons_optimisations`       To test the methodology. The original structure and the PROPTIMUS RAPHAN–optimised structure will be optimised with constrained alpha carbons. Short comparison will be stored in <data_dir>/comparison.json. Please note that optimisation with constrained alpha carbons is computationally expensive for larger protein structures.

### Example of executing the calculation:

```bash
raphan --PDB_file examples/P0DL07.pdb --data_dir P0DL07_test
```
For testing purposes, you can compare the optimised structure with the reference:

```bash
diff examples/P0DL07_optimised.pdb P0DL07_test/optimised_PDB/P0DL07_optimised.pdb
```
Please note that the resulting structures may vary slightly. This is due to numerical instabilities caused by running on different hardware.

## Running the calculation in the Docker container

```bash
# Build Docker container
docker build -t local/proptimus .

# Create folder for the results
mkdir results

# Run the computation
docker run --rm --name proptimus \
  -v ./examples:/opt/proptimus/examples \
  -v ./results:/opt/proptimus/results \
  local/proptimus \
  python raphan.py --PDB_file examples/P0DL07.pdb --data_dir results/P0DL07
```

## Reproduction of test results from the publication about PROPTIMUS RAPHAN

The comparison_scripts directory contains several Python scripts for reproducing the results from the publication. To run the scripts, you need to download and unzip the calculation.zip file from [supplementary files](https://onedata.e-infra.cz/ozw/onezone/i#/public/shares/baa17140ec395e18bd97e089d1c7b683ch7f7a).

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/sb-ncbr/proptimus_raphan/blob/main/LICENSE) file for details.
