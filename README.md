# PySubstrait
A python package for Substrait.

## Status
Work in progress.

# Getting Started
```
git clone --recursive https://github.com/voltrondata/substrait-python.git
cd substrait-python
```

# Setting up your environment
## Conda env
First, create a conda environment with the system dependencies.
```
conda env create -f environment.yml
conda activate pysubstrait
```

## Poetry
Second, install the python dependencies from within the conda environment using poetry.
```
poetry install
```

# Build
## PySubstrait package
Generate the protobuf files and subsequently build the python package wheel/sdist.
```
poetry build
```

## Generate protocol buffers
Generate only the protobuf files manually.
```
./gen_proto.sh
```

# Test
```
poetry run pytest
```

# Submodule
## Update the substrait submodule locally
```
git submodule sync --recursive
git submodule update --init --recursive
```
## Upgrade the substrait submodule
```
cd substrait
git checkout <version>
cd -
git commit . -m "Use submodule <version>"
```
