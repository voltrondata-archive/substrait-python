# Substrait
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
Create a conda environment with developer dependencies.
```
conda env create -f environment.yml
conda activate pysubstrait
```

# Build
## PySubstrait package
### Editable installation
```
pip install -e .
```

## Generate protocol buffers
Generate the protobuf files manually. Requires protobuf `v3.20.1`.
```
./gen_proto.sh
```

# Test
```
pytest
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
