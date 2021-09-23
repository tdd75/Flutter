import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sql.dart';

class DbHelpers {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      path.join(dbPath, 'user_places.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE user_places (id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      },
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbHelpers.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbHelpers.database();
    return db.query(table);
  }
}
