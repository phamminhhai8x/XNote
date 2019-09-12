import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xnote/Common/XTypeCommon.dart';
import 'XNoteItem.dart';
import 'package:sqflite/sqflite.dart';

import 'DBIf.DBQuery.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DBQuery.DATA_FILE_NAME);
    return await openDatabase(path, version: 1, onOpen: (db) async {
      await db.execute(DBQuery.NOTE_CREATE_TABLE);
    }, onCreate: (Database db, int version) async {
      await db.execute(DBQuery.NOTE_CREATE_TABLE);
    });
  }

  newClient(XNoteItem newClient) async {
    final db = await database;

    var table = await db.rawQuery(DBQuery.NOTE_GET_MAX_ID);
    int id = table.first["id"];

    var raw = await db.rawInsert(
        DBQuery.NOTE_INSERT_NEW, DBQuery.getArguments(id, newClient));
    return raw;
  }

  blockOrUnblock(XNoteItem client) async {
    final db = await database;
    XNoteItem blocked = client.clone();
    blocked.blocked = !client.blocked;

    var res = await db.update(DBQuery.NOTE_TABLE_NAME, blocked.toMap(),
        where: "id = ?", whereArgs: [client.id]);
    return res;
  }

  updateClient(XNoteItem newClient) async {
    final db = await database;
    var res = await db.update(DBQuery.NOTE_TABLE_NAME, newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  getClient(int id) async {
    final db = await database;
    var res = await db
        .query(DBQuery.NOTE_TABLE_NAME, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? XNoteItem.fromMap(res.first) : null;
  }

  Future<List<XNoteItem>> getBlockedClients() async {
    xLog("get");
    final db = await database;
    var res = await db
        .query(DBQuery.NOTE_TABLE_NAME, where: "blocked = ? ", whereArgs: [1]);

    List<XNoteItem> list =
        res.isNotEmpty ? res.map((c) => XNoteItem.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<XNoteItem>> getAllClients() async {
    xLog("getAll");
    final db = await database;

    var res = await db.query(DBQuery.NOTE_TABLE_NAME);
    List<XNoteItem> list =
        res.isNotEmpty ? res.map((c) => XNoteItem.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<XNoteItem>> getAllClientsSelected() async {
    final db = await database;
    var res = await db.query(DBQuery.NOTE_TABLE_NAME);
    List<XNoteItem> list =
        res.isNotEmpty ? res.map((c) => XNoteItem.fromMap(c)).toList() : [];
    return list;
  }

  deleteClient(int id) async {
    final db = await database;
    return db.delete(DBQuery.NOTE_TABLE_NAME, where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete(DBQuery.NOTE_DELETE_ALL);
  }
}
