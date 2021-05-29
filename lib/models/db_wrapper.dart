import 'package:good_reminder/models/model.dart';
import 'package:good_reminder/models/db.dart';

class DBWrapper {
  static final DBWrapper sharedInstance = DBWrapper._();

  DBWrapper._();

  Future<List<TodoItem>> getTodos() async {
    List list = await DB.sharedInstance.retrieveTodos();
    return list;
  }

  Future<List<TodoItem>> getDones() async {
    List list = await DB.sharedInstance.retrieveTodos(status: TodoStatus.done);
    return list;
  }

  Future<void> addTodo(TodoItem todo) async {
    await DB.sharedInstance.createTodo(todo);
  }

  Future<void> markTodoAsDone(TodoItem todo) async {
    todo.status = TodoStatus.done.index;
    todo.updated = DateTime.now();
    await DB.sharedInstance.updateTodo(todo);
  }

  Future<void> markDoneAsTodo(TodoItem todo) async {
    todo.status = TodoStatus.active.index;
    todo.updated = DateTime.now();
    await DB.sharedInstance.updateTodo(todo);
  }

  Future<void> deleteTodo(TodoItem todo) async {
    await DB.sharedInstance.deleteTodo(todo);
  }

  Future<void> deleteAllDoneTodos() async {
    await DB.sharedInstance.deleteAllTodos();
  }
}
