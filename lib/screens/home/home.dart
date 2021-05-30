import 'package:flutter/material.dart';
import 'package:good_reminder/screens/home/todo.dart';
import 'package:good_reminder/screens/home/calendar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  static List<Widget> _screenOptions = <Widget>[
    TodoList(),
    Calendar()
  ];
  //String _selection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: _screenOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.library_add_check_sharp), label: 'TodoList'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Calendar')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade400,
        onTap: _onItemTapped,
      ),
    );
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
