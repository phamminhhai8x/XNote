import pandas as pd
import unittest

from DataStruct import DataStruct as DS
from testing import compareIgnoreSpace


class TestDataStruct(unittest.TestCase):

    def test_init1(self):
        df = pd.read_excel('../lib/DB/DBTables.xlsx')
        theDS = DS(df)
        self.assertTrue(theDS.getName() == 'XNoteItem',
                        'init by DataFrame object')

    def test_init2(self):
        theDS = DS('../lib/DB/DBTables.xlsx')
        self.assertTrue(theDS.getName() == 'XNoteItem',
                        'init by path of xlsx file')
        self.assertTrue(theDS.elementsCount() == 22, 'element count')
        self.assertTrue(theDS.fieldsCount() == 3, 'field count')

    def test_init3(self):
        with self.assertRaises(TypeError):
            DS()

    def test_genDarkClassMembers(self):
        theDS = DS('../lib/DB/DBTables.xlsx')
        expect = """
  int             id;                             /// key identify
  String          summary;                        /// summary of note
  String          description;                    /// detail description
  bool            blocked;                        /// status view or not
  int             idTarget;                       /// index of parent note
  int             idUser;                         /// index of user create note
  int             xNoteType;                      /// note type
  int             createDate;                     /// create date (can't modify by user)
  int             startDatePlan;                  /// plan start date
  int             endDatePlan;                    /// plan end date
  int             startDateActual;                /// actual start date
  int             endDateActual;                  /// actual end date
  String          unitCost;                       /// unit of cost (day, hour, minute, second, dollar, lit , meter...)
  int             costEstimate;                   /// cost estimate
  int             costRemain;                     /// cost remain in-progress
  int             costUsed;                       /// cost used in-progress
  int             idUserOwner;                    /// id user detect or raise note
  int             idUserAssign;                   /// user follow to resolve this note
  int             level;                          /// level of note, at simple it 0, but if have a parent it is 1
  int             subNoteCount;                   /// if the note have child, this field will count it's children
  String          csvSubNoteList;                 /// the index of it children will store in this field
  int             status;                         /// status of note
"""

        self.assertTrue(theDS.genDartClassMembers() == expect,
                        'generate struct to dart class members')

    def test_genDarkClassConstructor(self):
        theDS = DS('../lib/DB/DBTables.xlsx')
        expect = """
XNoteItem({
  this.id,
  this.summary,
  this.description,
  this.blocked,
  this.idTarget,
  this.idUser,
  this.xNoteType,
  this.createDate,
  this.startDatePlan,
  this.endDatePlan,
  this.startDateActual,
  this.endDateActual,
  this.unitCost,
  this.costEstimate,
  this.costRemain,
  this.costUsed,
  this.idUserOwner,
  this.idUserAssign,
  this.level,
  this.subNoteCount,
  this.csvSubNoteList,
  this.status
});"""
        self.assertTrue(theDS.genDartClassConstructor() ==
                        expect, 'generate constructor dart class')

    def test_genDarkJson2Object(self):
        theDS = DS('../lib/DB/DBTables.xlsx')
        expect = """
factory XNoteItem.fromMap(Map<String, dynamic> json) {
  return new XNoteItem(
    id: json["id"] == null ? null : json["id"],
    summary: json["summary"] == null ? null : json["summary"],
    description: json["description"] == null ? null : json["description"],
    blocked: json["blocked"] == null ? false : json["blocked"] == 1,
    idTarget: json["idTarget"] == null ? null : json["idTarget"],
    idUser: json["idUser"] == null ? null : json["idUser"],
    xNoteType: json["xNoteType"] == null ? null : json["xNoteType"],
    createDate: json["createDate"] == null ? null : json["createDate"],
    startDatePlan: json["startDatePlan"] == null ? null : json["startDatePlan"],
    endDatePlan: json["endDatePlan"] == null ? null : json["endDatePlan"],
    startDateActual: json["startDateActual"] == null ? null : json["startDateActual"],
    endDateActual: json["endDateActual"] == null ? null : json["endDateActual"],
    unitCost: json["unitCost"] == null ? null : json["unitCost"],
    costEstimate: json["costEstimate"] == null ? null : json["costEstimate"],
    costRemain: json["costRemain"] == null ? null : json["costRemain"],
    costUsed: json["costUsed"] == null ? null : json["costUsed"],
    idUserOwner: json["idUserOwner"] == null ? null : json["idUserOwner"],
    idUserAssign: json["idUserAssign"] == null ? null : json["idUserAssign"],
    level: json["level"] == null ? null : json["level"],
    subNoteCount: json["subNoteCount"] == null ? null : json["subNoteCount"],
    csvSubNoteList: json["csvSubNoteList"] == null ? null : json["csvSubNoteList"],
    status: json["status"] == null ? null : json["status"],
  );
}"""
        self.assertTrue(theDS.genDartObjectFromMap() == expect,
                        'generate constructor dart class')

    def test_genDarkObject2Map(self):
        theDS = DS('../lib/DB/DBTables.xlsx')

        expect = """
Map<String, dynamic> toMap() => {
  "id": id == null ? null : id,
  "summary": summary == null ? null : summary,
  "description": description == null ? null : description,
  "blocked": blocked == null ? null : blocked,
  "idTarget": idTarget == null ? null : idTarget,
  "idUser": idUser == null ? null : idUser,
  "xNoteType": xNoteType == null ? null : xNoteType,
  "createDate": createDate == null ? null : createDate,
  "startDatePlan": startDatePlan == null ? null : startDatePlan,
  "endDatePlan": endDatePlan == null ? null : endDatePlan,
  "startDateActual": startDateActual == null ? null : startDateActual,
  "endDateActual": endDateActual == null ? null : endDateActual,
  "unitCost": unitCost == null ? null : unitCost,
  "costEstimate": costEstimate == null ? null : costEstimate,
  "costRemain": costRemain == null ? null : costRemain,
  "costUsed": costUsed == null ? null : costUsed,
  "idUserOwner": idUserOwner == null ? null : idUserOwner,
  "idUserAssign": idUserAssign == null ? null : idUserAssign,
  "level": level == null ? null : level,
  "subNoteCount": subNoteCount == null ? null : subNoteCount,
  "csvSubNoteList": csvSubNoteList == null ? null : csvSubNoteList,
  "status": status == null ? null : status,
};"""
        self.assertTrue(theDS.genDartObject2Map() == expect,
                        'generate constructor dart class')

    def test_toDarkClass(self):
        theDS = DS('../lib/DB/DBTables.xlsx')
#         print(theDS.genSqfliteCreateTableQuery())
        self.assertTrue(theDS.toDartClass() != '', 'gen Dart class')

    def test_genSqfliteCreateTableQuery(self):
        theDS = DS('../lib/DB/DBTables.xlsx')
        expect = """
"CREATE TABLE  IF NOT EXISTS XNoteItem ("
"id INTEGER PRIMARY KEY,"
"summary TEXT,"
"description TEXT,"
"blocked BIT,"
"idTarget INTEGER,"
"idUser INTEGER,"
"xNoteType INTEGER,"
"createDate INTEGER,"
"startDatePlan INTEGER,"
"endDatePlan INTEGER,"
"startDateActual INTEGER,"
"endDateActual INTEGER,"
"unitCost TEXT,"
"costEstimate INTEGER,"
"costRemain INTEGER,"
"costUsed INTEGER,"
"idUserOwner INTEGER,"
"idUserAssign INTEGER,"
"level INTEGER,"
"subNoteCount INTEGER,"
"csvSubNoteList TEXT,"
"status INTEGER"
")"
"""
        self.assertTrue(compareIgnoreSpace(
            theDS.genSqfliteCreateTableQuery(), expect), 'gen Create Table Query')

    def test_genSqfliteGetArguments(self):
        expect = """
  static List<dynamic> getArguments(int id, XNoteItem newItem) {
    return [
      id,
      newItem.summary,
      newItem.description,
      newItem.blocked,
      newItem.idTarget,
      newItem.idUser,
      newItem.xNoteType,
      newItem.createDate,
      newItem.startDatePlan,
      newItem.endDatePlan,
      newItem.startDateActual,
      newItem.endDateActual,
      newItem.unitCost,
      newItem.costEstimate,
      newItem.costRemain,
      newItem.costUsed,
      newItem.idUserOwner,
      newItem.idUserAssign,
      newItem.level,
      newItem.subNoteCount,
      newItem.csvSubNoteList,
      newItem.status
    ];
  }
"""
        theDS = DS('../lib/DB/DBTables.xlsx')

        self.assertTrue(compareIgnoreSpace(
            theDS.genSqfliteGetArgumentsFunc(), expect), 'gen Create Table Query')

    def test_baseType2SqfliteType(self):
        with self.assertRaises(KeyError):
            theDS = DS('../lib/DB/DBTables.xlsx')
            theDS.baseType2SqfliteType('bool1')

    def test_genSQLInsertItems(self):
        expect = """
"INSERT Into XNoteItem ("
          "id,"
          "summary,"
          "description,"
          "blocked,"
          "idTarget,"
          "idUser,"
          "xNoteType,"
          "createDate,"
          "startDatePlan,"
          "endDatePlan,"
          "startDateActual,"
          "endDateActual,"
          "unitCost,"
          "costEstimate,"
          "costRemain,"
          "costUsed,"
          "idUserOwner,"
          "idUserAssign,"
          "level,"
          "subNoteCount,"
          "csvSubNoteList,"
          "status"
          ")"
          " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
"""
        theDS = DS('../lib/DB/DBTables.xlsx')
        self.assertTrue(compareIgnoreSpace(
            theDS.genSQLInsertItems(), expect), 'gen insert new item SQL')

    def test_toSqfliteDBQueryClass(self):
        theDS = DS('../lib/DB/DBTables.xlsx')
        self.assertTrue(theDS.toSqfliteDBQueryClass() != '', 'gen DB')


if __name__ == '__main__':
    unittest.main()
