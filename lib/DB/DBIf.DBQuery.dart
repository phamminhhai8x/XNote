import 'XNoteItem.dart';

class DBQuery {
  static const DATA_FILE_NAME = "TestDB8.db";
  static const NOTE_TABLE_NAME = "XNoteItem";
  static const NOTE_CREATE_TABLE = "CREATE TABLE IF NOT EXISTS " +
      NOTE_TABLE_NAME +
      " ("
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
          ")";
  static const NOTE_GET_MAX_ID =
      "SELECT MAX(id)+1 as id FROM " + NOTE_TABLE_NAME;
  static const NOTE_INSERT_NEW = "INSERT Into " +
      NOTE_TABLE_NAME +
      " (id,"
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
  static const NOTE_DELETE_ALL = "Delete * from " + NOTE_TABLE_NAME;
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
}
