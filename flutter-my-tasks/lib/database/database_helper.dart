import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

class DatabaseHelper {
  static const _databaseName = 'my_tasks.db';
  static const _databaseVersion = 1;
  static const _tableName = 'tasks';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        text TEXT NOT NULL,
        category TEXT NOT NULL,
        priority TEXT NOT NULL,
        completed INTEGER NOT NULL DEFAULT 0,
        important INTEGER NOT NULL DEFAULT 0,
        createdAt TEXT NOT NULL,
        dueDate TEXT
      )
    ''');
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final maps = await db.query(_tableName, orderBy: 'createdAt DESC');
    return maps.map((m) => Task.fromMap(m)).toList();
  }

  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert(_tableName, task.toMap());
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update(
      _tableName,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(String id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> closeDatabase() async {
    final db = await database;
    db.close();
  }
}
