import 'package:flutter/material.dart';
import 'package:good_reminder/screens/authenticate/sing_in.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  SignIn(), //Cambiar por Register() para ver la ventana
    );
  }
}