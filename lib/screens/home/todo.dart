import 'package:flutter/material.dart';
import 'package:good_reminder/models/db_wrapper.dart';
import 'package:good_reminder/utils/utils.dart';
import 'package:good_reminder/models/model.dart' as Model;
import 'package:good_reminder/widgets/done.dart';
import 'package:good_reminder/widgets/header.dart';
import 'package:good_reminder/widgets/popup.dart';
import 'package:good_reminder/widgets/task_input.dart';
import 'package:good_reminder/widgets/todo.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  String titulo = "Good reminder";
  @override
  void initState() {
    super.initState();
    getTodosAndDones();
  }

  DateTime selectedDate = DateTime.now();
  List<Model.TodoItem> todos;
  List<Model.TodoItem> dones;
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Utils.hideKeyboard(context);
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Header(
                                    msg: titulo,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 35),
                                    child: Popup(
                                      getTodosAndDones: getTodosAndDones,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: TaskInput(
                                onSubmitted: addTaskInTodo,
                              ), // Add Todos
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              expandedHeight: 187,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  switch (index) {
                    case 0:
                      return Todo(
                        todos: todos,
                        onTap: markTodoAsDone,
                        onDeleteTask: deleteTask,
                      ); // Active todos
                    case 1:
                      return SizedBox(
                        height: 30,
                      );
                    default:
                      return Done(
                        dones: dones,
                        onTap: markDoneAsTodo,
                        onDeleteTask: deleteTask,
                      ); // Done todos
                  }
                },
                childCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getTodosAndDones() async {
    final _todos = await DBWrapper.sharedInstance.getTodos();
    final _dones = await DBWrapper.sharedInstance.getDones();
  
    setState(() {
      todos = _todos;
      dones = _dones;
    });
  }

  void addTaskInTodo(
      {@required TextEditingController controller,
      @required DateTime dateValue}) {
    final inputText = controller.text.trim();

    if (inputText.length > 0) {
      // Add todos
      Model.TodoItem todo = Model.TodoItem(
        title: inputText,
        created: DateTime.now(),
        updated: DateTime.now(),
        status: Model.TodoStatus.active.index,
        dateTodo: dateValue,
      );

      DBWrapper.sharedInstance.addTodo(todo);
      getTodosAndDones();
    } else {
      Utils.hideKeyboard(context);
    }

    controller.text = '';
  }

  void markTodoAsDone({@required int pos}) {
    DBWrapper.sharedInstance.markTodoAsDone(todos[pos]);
    getTodosAndDones();
  }

  void markDoneAsTodo({@required int pos}) {
    DBWrapper.sharedInstance.markDoneAsTodo(dones[pos]);
    getTodosAndDones();
  }

  void deleteTask({@required Model.TodoItem todo}) {
    DBWrapper.sharedInstance.deleteTodo(todo);
    getTodosAndDones();
  }
}
