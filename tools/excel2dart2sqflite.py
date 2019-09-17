# -*- coding: utf-8 -*-
from DataStruct import DataStruct as DS
import sys
import getopt
import os
from distutils import text_file


def main(argv):
    inputfile = ''
    outputdir = ''
    myName = os.path.basename(__file__)
    try:
        opts, args = getopt.getopt(argv, "hi:o:", ["ifile=", "oDir="])

    except getopt.GetoptError:
        print(myName + ' -i <inputfile.xlsx> [-o outputfolder]')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print(myName + ' -i <inputfile.xlsx> [-o outputfolder]')
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfile = arg
        elif opt in ("-o", "--oDir"):
            outputdir = arg
        else:
            print(myName + ' -i <inputfile.xlsx> [-o outputfolder>')
    if os.path.isfile(inputfile) == False:
        print('Can not find input file ' + inputfile)
    else:
        theDS = DS(inputfile)
        if not os.path.exists(outputdir):
            outputdir = '''D:\GENERATE\DB'''
            print('Warning use default output folder: ' +
                  os.path.abspath(outputdir))
            if not os.path.exists(outputdir):
                os.makedirs(outputdir)
        with open(outputdir + '/ClientModel.dart', 'w') as text_file:
            text_file.write(theDS.toDartClass())
        with open(outputdir + '/DBIf.DBQuery.dart', 'w') as text_file:
            text_file.write(theDS.toSqfliteDBQueryClass())


if __name__ == '__main__':
    main(sys.argv[1:])
