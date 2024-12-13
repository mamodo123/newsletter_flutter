import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class SQLiteHelper {
  static Future<Database> getDatabase(
      String databasePath, int version, List<String> onCreate) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, databasePath);

    final database = await openDatabase(path, version: version,
        onCreate: (Database db, int version) async {
      for (final onCreateCommand in onCreate) {
        await db.execute(onCreateCommand);
      }
    });

    return database;
  }

  static Future<List<Map<String, Object?>>> runSelectSql(
      String sql, Database db, List<Object> arguments) async {
    return await db.rawQuery(sql, arguments);
  }

  static Future<int> runInsertSql(
    String table,
    Map<String, Object?> items,
    Database db,
  ) async {
    return await db.insert(table, items,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> runUpdateSql(
      String sql, Database db, List<Object> arguments) async {
    return await db.rawUpdate(sql, arguments);
  }
}
