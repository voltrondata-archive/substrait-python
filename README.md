# Substrait
[Substrait](https://substrait.io) is a cross-language specification for data compute operations.

## Goals
The Substrait Python package aims to provide a Python interface to Substrait. It will allow users to construct and manipulate a Substrait Plan from Python for evaluation by a Substrait consumer, such as DataFusion or DuckDB.

## Non-goals
The Substrait Python package is not an execution engine for Substrait Plans.

## Status
This is an experimental package that is still under development.

# Example
At the moment, this package contains only generated Python classes for the Substrait protobuf messages. Let's use an existing Substrait producer, [Ibis](https://ibis-project.org), to provide an example.
## Generate a Substrait Plan with Ibis
```
In [1]: import ibis

In [2]: movie_ratings = ibis.table(
   ...:     [
   ...:         ("tconst", "str"),
   ...:         ("averageRating", "str"),
   ...:         ("numVotes", "str"),
   ...:     ],
   ...:     name="ratings",
   ...: )
   ...: 

In [3]: query = movie_ratings.select(
   ...:     movie_ratings.tconst,
   ...:     avg_rating=movie_ratings.averageRating.cast("float"),
   ...:     num_votes=movie_ratings.numVotes.cast("int"),
   ...: )

In [4]: from ibis_substrait.compiler.core import SubstraitCompiler

In [5]: compiler = SubstraitCompiler()

In [6]: protobuf_msg = compiler.compile(query).SerializeToString()

In [7]: type(protobuf_msg)
Out[7]: bytes
```
## Read the Plan protobuf message using Substrait Python
```
In [8]: import substrait

In [9]: from substrait.proto.pysubstrait.plan_pb2 import Plan

In [10]: my_plan = Plan()

In [11]: my_plan.ParseFromString(protobuf_msg)
Out[11]: 186

In [12]: print(my_plan)
relations {
  root {
    input {
      project {
        common {
          emit {
            output_mapping: 3
            output_mapping: 4
            output_mapping: 5
          }
        }
        input {
          read {
            common {
              direct {
              }
            }
            base_schema {
              names: "tconst"
              names: "averageRating"
              names: "numVotes"
              struct {
                types {
                  string {
                    nullability: NULLABILITY_NULLABLE
                  }
                }
                types {
                  string {
                    nullability: NULLABILITY_NULLABLE
                  }
                }
                types {
                  string {
                    nullability: NULLABILITY_NULLABLE
                  }
                }
                nullability: NULLABILITY_REQUIRED
              }
            }
            named_table {
              names: "ratings"
            }
          }
        }
        expressions {
          selection {
            direct_reference {
              struct_field {
              }
            }
            root_reference {
            }
          }
        }
        expressions {
          cast {
            type {
              fp64 {
                nullability: NULLABILITY_NULLABLE
              }
            }
            input {
              selection {
                direct_reference {
                  struct_field {
                    field: 1
                  }
                }
                root_reference {
                }
              }
            }
            failure_behavior: FAILURE_BEHAVIOR_THROW_EXCEPTION
          }
        }
        expressions {
          cast {
            type {
              i64 {
                nullability: NULLABILITY_NULLABLE
              }
            }
            input {
              selection {
                direct_reference {
                  struct_field {
                    field: 2
                  }
                }
                root_reference {
                }
              }
            }
            failure_behavior: FAILURE_BEHAVIOR_THROW_EXCEPTION
          }
        }
      }
    }
    names: "tconst"
    names: "avg_rating"
    names: "num_votes"
  }
}
```

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
## Python package
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
