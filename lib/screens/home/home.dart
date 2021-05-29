import 'package:flutter/material.dart';
import 'package:good_reminder/servicios/auth_conf.dart';
import 'package:good_reminder/widgets/header.dart';
import 'package:good_reminder/widgets/task_input.dart';
import 'package:good_reminder/widgets/todo.dart';
import 'package:good_reminder/widgets/done.dart';
import 'package:good_reminder/models/model.dart' as Model;
import 'package:good_reminder/models/db_wrapper.dart';
import 'package:good_reminder/utils/utils.dart';
import 'package:good_reminder/widgets/popup.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  final AuthConfigurationService _auth = AuthConfigurationService();

  String titulo = "Good reminder";
  List<Model.TodoItem> todos;
  List<Model.TodoItem> dones;
  //String _selection;

  @override
  void initState() {
    super.initState();
    getTodosAndDones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
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
                expandedHeight: 200,
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add_check_sharp),
            label: 'TodoList'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar')
        ],
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

  void addTaskInTodo({@required TextEditingController controller}) {
    final inputText = controller.text.trim();

    if (inputText.length > 0) {
      // Add todos
      Model.TodoItem todo = Model.TodoItem(
        title: inputText,
        created: DateTime.now(),
        updated: DateTime.now(),
        status: Model.TodoStatus.active.index,
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
/*
class Home extends StatelessWidget {
  final AuthConfigurationService _auth = AuthConfigurationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text("Conseguido"),
        backgroundColor: Colors.brown[500],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.green,
                size: 30.0,
              ),
              label: Text('Logout'))
        ],
      ),
    );
  }
}
*/
