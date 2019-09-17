#!/bin/bash

export PYTHONPATH=./tools/
#export PYTHONWARNINGS="ignore"

python tools/excel2dart2sqflite.py -h
python tools/excel2dart2sqflite.py -i lib/DB/DBTables
python tools/excel2dart2sqflite.py -i lib/DB/DBTables.xlsx



