#!/bin/bash

export PYTHONPATH=.
export PYTHONWARNINGS="ignore"

printf "testing/DataFrameOp_Test.py: "
coverage run testing/DataFrameOp_Test.py

printf "testing/DataStruct_Test.py: "
coverage run -a testing/DataStruct_Test.py

coverage report -m
