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

  Future<void> addData(SQLFunction input) async {
    try {
      await openService();
      var c = await checkData(input, initService: false);
      if (c > 0){
        print("addData - updateData");
        updateData(input,initService: false);
      }else{
        print("addData - insertData");
        insertData(input,initService: false);
      }
      await closeService();
    } catch (ex) {
      print(ex);
    }
  }

  Future<int> checkData(SQLFunction input, {bool initService = true,String keyCompare = "like" }) async {
    try {
      var key = input.getPrimaryKey();
      if (initService) {
        await openService();
      }

      var data = await db.query(
        input.getNameTableSQL(),
        where: "$key $keyCompare ?",
        whereArgs: [input.getValuePrimaryKey()],
      );
      print(data);

      if (initService) {
        await closeService();
      }
      return data?.length;
    } catch (ex) {
      print(ex);
    }
    return -1;
  }

  Future<void> insertData(SQLFunction input, {bool initService = true}) async {
    try {

      if (initService) {
        await openService();
      }

      await db.insert(
        input.getNameTableSQL(),
        input.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      if (initService) {
        await closeService();
      }

    } catch (ex) {
      print(ex);
    }
  }

  Future<void> updateData(SQLFunction input, {bool initService = true,String keyCompare = "like"}) async {
    try {
      var key = input.getPrimaryKey();

      if (initService) {
        await openService();
      }

      await db.update(
        input.getNameTableSQL(),
        input.toMap(),
        where: "$key $keyCompare ?",
        whereArgs: [input.getValuePrimaryKey()],
      );

      if (initService) {
        await closeService();
      }

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
