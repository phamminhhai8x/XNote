# -*- coding: utf-8 -*-
from DataFrameOp import DataFrameOp as Base
import sys
from pandas.tests.indexes.multi import test_reindex


class DataStruct(Base):
    MAX_TYPE_NAME_LENGTH = 16
    MAX_MEMBER_NAME_LENGTH = 32
    TAB_SIZE = 2
    IMPORT_DART_CONVERT = "import 'dart:convert';"
    DB_DATA_BASE_NAME = "TestDB7.db"

    IMPORT_DART_SQFLITE = \
        """
import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xnote/Common/XTypeCommon.dart';
import 'ClientModel.dart';
import 'package:sqflite/sqflite.dart';
"""

    def __init__(self, theDataFrame):
        ''' Base on DataFrameOp and remove Unnamed column indexer'''
        Base.__init__(self, theDataFrame)
        unNameCol = [col for col in self.theDF.columns if 'Unnamed' in col]
        if not unNameCol is None:

            # myDic = dict(zip(self.theDF.columns.values.tolist(),self.theDF.iloc[0].values.tolist()))
            # df = self.theDF.rename(columns = myDic)

            # myDic = {self.theDF.columns.values[i] : self.theDF.iloc[0].values[i] for i in range(self.theDF.columns.size)}
            # df = self.theDF.rename(columns = myDic)
            # use first row for column indexer
            df = self.theDF.rename(
                columns=dict(
                    zip(
                        self.theDF.columns.values.tolist(),
                        self.theDF.iloc[0].values.tolist()
                    )
                )
            )
            df = df.drop(df.index[0])
            self.theDF = df

    def elementsCount(self):
        return len(self.theDF.index)

    def fieldsCount(self):
        return len(self.theDF.columns)

    def toDartClass(self):
        rs = self.IMPORT_DART_CONVERT
        rs = rs + self.genDartObjectFromJson()
        rs = rs + self.genDartObjectToJson()
        rs = rs + "class " + self.theName + " {"
        rs = rs + self.genDartClassMembers()
        rs = rs + self.genDartClassConstructor()
        rs = rs + self.genDartCloneFunction()
        rs = rs + self.genDartObjectFromMap()
        rs = rs + self.genDartObject2Map()
        rs = rs + "\n}"
        return rs

    def genDartClassMembers(self):
        rs = ''.join(
            [''.join(
                "\n" + ''.ljust(self.TAB_SIZE) +
                self.genDartClassMember(
                    str(self.theDF.iloc[i]['Type']),
                    str(self.theDF.iloc[i]['Name']),
                    str(self.theDF.iloc[i]['Description']))
            )
                for i in range(self.elementsCount())
            ]
        )
        return rs + '\n'

    def genDartClassMember(self, typeMember, nameMember, desMember):
        return typeMember.ljust(
            self.MAX_TYPE_NAME_LENGTH
            if len(typeMember) < self.MAX_TYPE_NAME_LENGTH
            else len(typeMember) + 1
        ) \
            +\
            (nameMember + ";").ljust(
            self.MAX_MEMBER_NAME_LENGTH
            if len(nameMember) < self.MAX_MEMBER_NAME_LENGTH
            else len(nameMember) + 1
        ) \
            +\
            "/// " + desMember

    def genDartClassConstructor(self):
        rs = "\n" + self.theName + "({"
        rs = rs + ''.join([''.join(
            "\n" + ''.ljust(self.TAB_SIZE) + "this." +
            str(self.theDF.iloc[i]['Name'] +
                (',' if i < self.elementsCount() - 1 else ''))
            for i in range(self.elementsCount()))])
        rs = rs + "\n});"
        return rs

    def genDartObjectFromMap(self):
        rs = '\nfactory ' + self.theName + \
            '.fromMap(Map<String, dynamic> json) {'
        rs = rs + '\n' + ''.ljust(self.TAB_SIZE) + \
            'return new ' + self.theName + '('

        rs = rs + ''.join(
            [
                "\n" + ''.ljust(self.TAB_SIZE * 2) +
                self.genDartJson2Member(
                    str(self.theDF.iloc[i]['Name']),
                    str(self.theDF.iloc[i]['Type'])
                )
                for i in range(self.elementsCount())
            ]
        )

        rs = rs + '\n' + ''.ljust(self.TAB_SIZE) + ');'
        rs = rs + '\n}'
        return rs

    def genDartJson2Member(self, memberName, memberType):
        ''' get Dart member'''
        return memberName + ': json["' + memberName + '"] == null ? ' + \
            ('null' if memberType != 'bool' else 'false') + \
            ' : json["' + memberName + \
            ('"],' if memberType != 'bool' else '"] == 1,')

    def genDartObject2Map(self):
        rs = "\nMap<String, dynamic> toMap() => {"
        rs = rs + ''.join(["\n" + ''.ljust(self.TAB_SIZE) +
                           self.genDartMember2Map(
                               str(self.theDF.iloc[i]['Name']))
                           for i in range(self.elementsCount())
                           ])
        rs = rs + '\n};'
        return rs

    def genDartMember2Map(self, memberName):
        return '"' + memberName + '": ' + memberName + ' == null ? null : ' + memberName + ','

    def genDartCloneFunction(self):
        return """
  %s clone(){
    return %s.fromMap( this.toMap());
  }
""" % (self.theName, self.theName)

    def genDartObjectFromJson(self):
        rs = \
            """
%s clientFromJson(String str){
    final jsonData = json.decode(str);
    return %s.fromMap(jsonData);
}
"""
        return rs % (self.theName, self.theName)

    def genDartObjectToJson(self):
        rs = \
            """
String clientToJson(%s data) {
    final dyn = data.toMap();
    return json.encode(dyn);
}
"""
        return rs % (self.theName)

    def toSqfliteDBQueryClass(self):
        rs = """
import '%s.dart';

class DBQuery {
  static const DATA_FILE_NAME = "%s.db";
  static const TABLE_NAME = "%s";
  static const CREATE_TABLE = "%s";
  static const NOTE_GET_MAX_ID =
      "SELECT MAX(id)+1 as id FROM " + TABLE_NAME;
  static const INSERT_NEW = %s;
  static const DELETE_ALL = "Delete * from " + TABLE_NAME;
  %s
}
"""
        return rs % (
            self.theName,
            'TestDB8',
            self.theName,
            self.genSqfliteCreateTableQuery(),
            self.genSQLInsertItems(),
            self.genSqfliteGetArgumentsFunc()
        )

    def genSqfliteGetArgumentsFunc(self):
        '''generate function getArguments which is used for SQLite insert query agruments'''
        objectName = 'newItem'
        rs = \
            """
static List<dynamic> getArguments(int id, %s %s) {
    return [%s
    ];
}
"""
        return rs % (self.theName, objectName, (''.join(
            ['\n' + self.genSqfliteGetArgumentMember(i, objectName)
             for i in range(self.elementsCount())])))

    def genSqfliteGetArgumentMember(self, index, objectName):
        '''generate an argument member at index with object Name.'''
        myName = str(self.theDF.iloc[index]['Name'])
        return (objectName + '.' if myName != 'id' else '') + \
            myName + \
            (',' if index < self.elementsCount() - 1 else '')

    def genSqfliteCreateTableQuery(self):
        return '"CREATE TABLE IF NOT EXISTS ' + self.theName + ' ("' + \
            ''.join(['\n' + self.genSqfliteCreateMember(i) for i in range(self.elementsCount())]) + \
            '\n")"'

    def genSQLInsertItems(self):
        '''generate insert SQL query from theDF and theName of struct'''
        return (
            '"INSERT Into ' + self.theName + ' ("' +
            ''.join([
                '\n' + self.genSQLInsertItem(i)
                for i in range(self.elementsCount())
            ]) +
            '\n")"' +
            '\n" VALUES (' + '?,' * (self.elementsCount() - 1) + '?)";'
        )

    def genSQLInsertItem(self, index):
        return (
            '"' + str(self.theDF.iloc[index]['Name']) +
            (',"' if index < self.elementsCount() - 1 else '"')
        )

    def genSqfliteCreateMember(self, index):
        myName = str(self.theDF.iloc[index]['Name'])
        myType = str(self.theDF.iloc[index]['Type'])
        return '"' + myName + ' ' + \
            self.baseType2SqfliteType(myType) + \
            ('"' if index == self.elementsCount() -
             1 else ',"' if myName != 'id' else ' PRIMARY KEY,"')

    def baseType2SqfliteType(self, typeName):
        try:
            return{
                'int': 'INTEGER',
                'bool': 'BIT',
                'double': 'REAL',
                'object': 'BLOB',
                'String': 'TEXT'
            }[typeName]
        except:
            print("Sqflite unsupport type: %s" % (typeName), sys.exc_info()[0])
            raise
