import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sql_crud/crud_oject.dart';

class DbProvider {
  static Database? database;
  var dbName = "NotesDb";
  DbProvider() {
    createDb();
  }

// Database Create
  Future<Database> createDb() async {
    if (kIsWeb) {
      var databaseFactory = databaseFactoryFfiWeb;
      database = await databaseFactory.openDatabase(
        dbName,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) async {
            await db.execute(
                "CREATE TABLE notesDb(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)");
          },
        ),
      );
    } else {
      var path = join(await getDatabasesPath(), dbName);
      return openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
              "CREATE TABLE notesDb(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)");
        },
      );
    }
    return Future.value(database);
  }

  // insert Data

  void insertData(CrudObject crudObject) async {
    var db = await createDb();
    db.insert('notesDb', crudObject.toJson());
  }

  // get data

  Future<List<CrudObject>> getData() async {
    var db = await createDb();
    final List<Map<String, dynamic>> maps = await db.query('notesDb');
    return List.generate(
      maps.length,
      (i) {
        return CrudObject(
          id: maps[i]['id'],
          title: maps[i]['title'],
          description: maps[i]['description'],
        );
      },
    );
  }

  // delete data

  void deleteData(CrudObject crud_object) async {
    var db = await createDb();
    db.delete(
      'notesDb',
      where: "id = ?",
      whereArgs: [crud_object.id],
    );
  }

  // update data

  void updateData(CrudObject crud_object, int id) async {
    var db = await createDb();
    db.update(
      'notesDb',
      crud_object.toJson(),
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
