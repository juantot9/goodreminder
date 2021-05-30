import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:good_reminder/screens/authenticate/sing_in.dart';
import 'package:good_reminder/servicios/auth_conf.dart';
import 'package:good_reminder/models/db_wrapper.dart';
import 'package:good_reminder/utils/utils.dart';

class Popup extends StatelessWidget {
  final Function getTodosAndDones;
  final AuthConfigurationService _auth = AuthConfigurationService();

  Popup({this.getTodosAndDones});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
        elevation: 4,
        icon: Icon(Icons.more_vert),
        onSelected: (value) async {
          print('Selected value: $value');
          if (value == kMoreOptionsKeys.clearAll.index) {
            Utils.showCustomDialog(context,
                title: '¿Estás seguro?',
                msg: 'Todos los objetos serán borrados permanentemente',
                onConfirm: () {
              DBWrapper.sharedInstance.deleteAllDoneTodos();
              getTodosAndDones();
            });
          } else if (value == kMoreOptionsKeys.logOut.index) {
            await _auth.signOut();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignIn()));

            FirebaseAuth.instance.authStateChanges().listen((User user) {
              if (user == null) {
                print('User is currently signed out!');
              } else {
                print('User is signed in!');
              }
            });
          }
        },
        itemBuilder: (context) {
          List list = List<PopupMenuEntry<int>>.empty(growable: true);

          for (int i = 0; i < kMoreOptionsMap.length; ++i) {
            list.add(PopupMenuItem(value: i, child: Text(kMoreOptionsMap[i])));

            if (i == 0) {
              list.add(PopupMenuDivider(
                height: 5,
              ));
            }
          }

          return list;
        });
  }
}
