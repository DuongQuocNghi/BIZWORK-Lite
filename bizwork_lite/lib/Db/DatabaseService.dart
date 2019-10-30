import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'SQLFunction.dart';

class DatabaseService {
  final String dbName = "bizwork_database.db";
  Database db;
  String path;

  Future<bool> openService() async {
    try {
      var databasesPath = await getDatabasesPath();
      path = join(databasesPath, dbName);
      db = await openDatabase(path);
      return db != null ? true : false;
    } catch (ex) {
      print(ex);
    }
    return false;
  }

  Future<void> closeService() async {
    try {
      await db.close();
    } catch (ex) {
      print(ex);
    }
  }

  Future<void> createTable(SQLFunction input) async {
    try {
      await openService();
      await db.execute(input.toTableSQL());
      await closeService();
    } catch (ex) {
      print(ex);
    }
  }

  Future<void> insertData(SQLFunction input) async {
    try {
      await openService();
      await db.insert(
        input.getNameTableSQL(),
        input.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await closeService();
    } catch (ex) {
      print(ex);
    }
  }

  Future<List<T>> getData<T>(SQLFunction input) async {
    try {
      await openService();
      final List<Map<String, dynamic>> maps =
          await db.query(input.getNameTableSQL());
      await closeService();

      return List.generate(maps.length, (i) {
        return input.fromJson(maps[i]);
      });
    } catch (ex) {
      print(ex);
    }
    return List<T>();
  }

  Future<void> updateData(SQLFunction input) async {
    try {
      var key = input.getPrimaryKey();
      await openService();
      await db.update(
        input.getNameTableSQL(),
        input.toMap(),
        where: "$key = ?",
        whereArgs: [input.getValuePrimaryKey()],
      );
      await closeService();
    } catch (ex) {
      print(ex);
    }
  }

  Future<void> deleteData(SQLFunction input) async {
    try {
      var key = input.getPrimaryKey();
      await openService();
      await db.delete(
        input.getNameTableSQL(),
        where: "$key = ?",
        whereArgs: [input.getValuePrimaryKey()],
      );
      await closeService();
    } catch (ex) {
      print(ex);
    }
  }
}
