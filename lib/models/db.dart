import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:good_reminder/models/model.dart';

const kTodosStatusActive = 0;
const kTodosStatusDone = 1;

const kDatabaseName = 'todos.db';
const kDatabaseVersion = 2;
const kSQLCreateStatement = '''
CREATE TABLE "todos" (
	 "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "title" TEXT NOT NULL,
	 "created" TEXT NOT NULL,
	 "updated" TEXT NOT NULL,
	 "status" integer DEFAULT $kTodosStatusActive,
   "dateTodo" TEXT NOT NULL
);
''';

const kTableTodos = 'todos';

class DB {
  DB._();
  static final DB sharedInstance = DB._();

  Database _database;
  Future<Database> get database async {
    return _database ?? await initDB();
  }

  Future<Database> initDB() async {
    Directory docsDirectory = await getApplicationDocumentsDirectory();
    String path = join(docsDirectory.path, kDatabaseName);
    
    return await openDatabase(path, version: kDatabaseVersion,
        onCreate: (Database db, int version) async {
      await db.execute(kSQLCreateStatement);
    });
  }

  void createTodo(TodoItem todo) async {
    final db = await database;
    await db.insert(kTableTodos, todo.toMapAutoID());
  }

  void updateTodo(TodoItem todo) async {
    final db = await database;
    await db
        .update(kTableTodos, todo.toMap(), where: 'id=?', whereArgs: [todo.id]);
  }

  void deleteTodo(TodoItem todo) async {
    final db = await database;
    await db.delete(kTableTodos, where: 'id=?', whereArgs: [todo.id]);
  }

  void deleteAllTodos({int status = kTodosStatusDone}) async {
    final db = await database;
    await db.delete(kTableTodos, where: 'status=?', whereArgs: [status]);
  }

  Future<List<TodoItem>> retrieveTodos(
      {TodoStatus status = TodoStatus.active}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(kTableTodos,
        where: 'status=?', whereArgs: [status.index], orderBy: 'updated ASC');

    // Convert List<Map<String, dynamic>> to List<Todo_object>
    return List.generate(maps.length, (i) {
      return TodoItem(
        id: maps[i]['id'],
        title: maps[i]['title'],
        created: DateTime.parse(maps[i]['created']),
        updated: DateTime.parse(maps[i]['updated']),
        status: maps[i]['status'],
        dateTodo: DateTime.parse(maps[i]['dateTodo']),
      );
    });
  }
}
