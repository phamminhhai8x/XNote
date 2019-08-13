import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'ClientModel.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB6.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Client ("
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
              ")");
        });
  }

  newClient(XNoteItem newClient) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Client");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Client (id,"
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
            " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
        [
          id,
          newClient.summary,
          newClient.description,
          newClient.blocked,
          newClient.idTarget,
          newClient.idUser,
          newClient.xNoteType,
          newClient.createDate,
          newClient.startDatePlan,
          newClient.endDatePlan,
          newClient.startDateActual,
          newClient.endDateActual,
          newClient.unitCost,
          newClient.costEstimate,
          newClient.costRemain,
          newClient.costUsed,
          newClient.idUserOwner,
          newClient.idUserAssign,
          newClient.level,
          newClient.subNoteCount,
          newClient.csvSubNoteList,
          newClient.status
        ]);
    return raw;
  }

  blockOrUnblock(XNoteItem client) async {
    final db = await database;
    XNoteItem blocked = client.clone();
    blocked.blocked = !client.blocked;
//    XNoteItem(
//        id: client.id,
//        summary: client.summary,
//        description: client.description,
//        blocked: !client.blocked);
    var res = await db.update("Client", blocked.toMap(),
        where: "id = ?", whereArgs: [client.id]);
    return res;
  }

  updateClient(XNoteItem newClient) async {
    final db = await database;
    var res = await db.update("Client", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  getClient(int id) async {
    final db = await database;
    var res = await db.query("Client", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? XNoteItem.fromMap(res.first) : null;
  }

  Future<List<XNoteItem>> getBlockedClients() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
    var res = await db.query("Client", where: "blocked = ? ", whereArgs: [1]);

    List<XNoteItem> list =
    res.isNotEmpty ? res.map((c) => XNoteItem.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<XNoteItem>> getAllClients() async {
    final db = await database;
    var res = await db.query("Client");
    List<XNoteItem> list =
    res.isNotEmpty ? res.map((c) => XNoteItem.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<XNoteItem>> getAllClientsSelected() async {
    final db = await database;
    var res = await db.query("Client" );
    List<XNoteItem> list =
    res.isNotEmpty ? res.map((c) => XNoteItem.fromMap(c)).toList() : [];
    return list;
  }

  deleteClient(int id) async {
    final db = await database;
    return db.delete("Client", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Client");
  }
}