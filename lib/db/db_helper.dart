import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:theme_change_project/Models/task.dart';

class DbHelper {
  static Database? _db;
  static final int _verson = 1;
  static final String _tableName = "task";

  static Future<void> initDb() async {
    if ( _db != null){
      return ;
    } try
        {
          String _path = await getDatabasesPath() + 'tasks.db';
          _db = await openDatabase(
            _path,
            version: _verson,
            onCreate: (db, verson){
              print("Creating a new one");
              return db.execute(
                "CREATE TABLE $_tableName("
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "title STRINGS, note TEXT, date STRINGS, "
              "startTime STINGS, endTime STRINGS, "
              "remind INTEGERS, repeat STRINGS, "
              " color INTEGERS,"
              " isCompleted INTEGERS)",
              );
            },
          );
        } catch (e){
      print(e);
    }
  }
  static Future<int> insert(Task? task) async {
    print("insert function called");
    return await _db?.insert(_tableName, task!.toJson())??1;
  }

  static Future<List<Map<String, dynamic>>> query() async{
    print("query function is called");
    return await _db!.query(_tableName);
  }
  static delete(Task task) async{
    return await _db!.delete(_tableName, where: "id=?", whereArgs: [task.id]);
  }
  static update(int id) async{
   return await _db!.rawUpdate('''
    UPDATE task
    SET isCompleted = ?
    WHERE id = ?
    ''', [1, id]);
  }
}