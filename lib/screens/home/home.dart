import 'package:flutter/material.dart';
import 'package:good_reminder/servicios/auth_conf.dart';

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
                Icons.child_friendly_rounded,
                color: Colors.green,
                size: 30.0,
              ),
              label: Text('Logout'))
        ],
      ),
    );
  }
}
