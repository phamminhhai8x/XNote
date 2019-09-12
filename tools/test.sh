#!/bin/bash

export PYTHONPATH=.
export PYTHONWARNINGS="ignore"
# echo "testing/excel2dart2sqflite_test.py"
# coverage run testing/excel2dart2sqflite_test.py

printf "testing/DataFrameOp_Test.py: "
coverage run testing/DataFrameOp_Test.py

printf "testing/DataStruct_Test.py: "
coverage run -a testing/DataStruct_Test.py
#coverage run -m unittest discover -v tests
coverage report -m
