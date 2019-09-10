#!/bin/bash

export PYTHONPATH=.
export PYTHONWARNINGS="ignore"
# echo "testing/excel2dart2sqflite_test.py"
# coverage run testing/excel2dart2sqflite_test.py

# echo "testing/DataFrameOp_Test.py"
# coverage run -a testing/DataFrameOp_Test.py

echo "testing/DataStruct_Test.py"
coverage run -a testing/DataStruct_Test.py
#coverage run -m unittest discover -v tests
coverage report -m
