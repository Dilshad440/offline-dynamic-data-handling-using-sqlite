import 'package:offline_storage/response/response.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfLiteService {
  Future<Database> initializeDb({JakeWharton? data}) async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, "databse.db"),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE Jake(${createColoums(data!.toJson())})",
        );
      },
      version: 1,
    );
  }

  Future<void> insertIntoDb(JakeWharton data) async {
    final db = await initializeDb(data: data);
    db.insert(
      "Jake",
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<JakeWharton>> getFromDb() async {
    final db = await initializeDb();

    final data = await db.query("Jake");
    return data.map((e) => JakeWharton.fromJson(e)).toList();
  }

  String createColoums(Map<dynamic, dynamic> map) {
    String column = ' ';
    map.forEach((key, value) {
      column += '$key ${getType(value.runtimeType)},';
    });

    return column.endsWith(',')
        ? column.substring(0, column.length - 2)
        : column;
  }

  String getType(Type type) {
    switch (type) {
      case int:
        return "INTEGER";
      case String:
        return "TEXT";
      case double:
        return "REAL";
      case num:
        return "NUMERIC";
      case bool:
        return "BOOLEAN";
      default:
        return "TEXT";
    }
  }
}
