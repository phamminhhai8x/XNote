#!/bin/bash

export PYTHONPATH=.
export PYTHONWARNINGS="ignore"
echo "testing/excel2dart2sqflite_test.py"
coverage run testing/excel2dart2sqflite_test.py

coverage report -m
