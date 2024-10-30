import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:movie_assessment/domain/models/PopularPersonModel.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('popular_persons.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE persons (
      id INTEGER PRIMARY KEY,
      name TEXT,
      profilePath TEXT,
      popularity REAL
    )
    ''');
  }

  Future<void> insertPersons(List<Results> persons) async {
    final db = await instance.database;
    for (var person in persons) {
      await db.insert('persons', person.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<Results>> fetchPersons() async {
    final db = await instance.database;
    final result = await db.query('persons');
    return result.map((json) => Results.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
