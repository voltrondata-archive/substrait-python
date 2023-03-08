# Substrait Python
The Substrait Python package provides a Python interface to Substrait, allowing users to construct a Substrait plan from Python for evaluation by a Substrait consumer.

## Status
Work in progress.

# Getting Started
```
git clone --recursive https://github.com/voltrondata/substrait-python.git
cd substrait-python
```

# Build
## Conda env
```
conda env create -f environment.yml
conda activate pysubstrait
```

## Generate protocol buffers
```
./gen_proto
```

# Submodule
## Update the substrait submodule locally
```
git submodule sync --recursive
git submodule update --init --recursive
```
## Upgrade the substrait submodule
```
cd proto/substrait
git checkout <version>
cd -
git commit . -m "Use submodule <version>"
```
