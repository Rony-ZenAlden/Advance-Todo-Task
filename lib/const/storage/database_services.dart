import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../Models/task_model.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._constructor();
  static Database? _db;

  final String _tasksTableName = 'tasks';
  final String _tasksIdColumnName = 'id';
  final String _tasksNameColumnName = 'name';
  final String _tasksDetailColumnName = 'detail';
  final String _tasksDateColumnName = 'date';

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'aster_db.db');
    final database =
        await openDatabase(databasePath, version: 1, onCreate: (db, version) {
      db.execute('''
      CREATE TABLE $_tasksTableName (
        $_tasksIdColumnName INTEGER PRIMARY KEY,
        $_tasksNameColumnName TEXT NOT NULL,
        $_tasksDetailColumnName TEXT NOT NULL,
        $_tasksDateColumnName TEXT NOT NULL
      );
    ''');
    });
    return database;
  }

  Future<List<TaskModel>?> getTasks() async {
    final db = await database;
    final data = await db.query(_tasksTableName);
    List<TaskModel> tasks = data
        .map(
          (e) => TaskModel(
            id: e['id'] as int,
            taskName: e['name'] as String,
            taskDetail: e['detail'] as String,
            date: e['date'] as String,
          ),
        )
        .toList();
    return tasks;
  }

  void deleteTask(int id) async {
    final db = await database;
    await db.delete(
      _tasksTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

void addTask(String name,String detail,String date) async {
  final db = await database;
  await db.insert(_tasksTableName, {
    _tasksNameColumnName: name,
    _tasksDetailColumnName: detail,
    _tasksDateColumnName: date,
  });
}

// void updateTaskStatus(int id, int status) async {
//   final db = await database;
//   await db.update(
//     _tasksTableName,
//     {
//       _tasksStatusColumnName: status,
//     },
//     where: 'id = ?',
//     whereArgs: [
//       id,
//     ],
//   );
// }
}
