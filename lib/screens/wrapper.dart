import 'package:flutter/material.dart';
import 'package:good_reminder/screens/authenticate/authenticate.dart';
import 'package:good_reminder/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    
    //DEvolvemos Home o Autenticacion.
    return Authenticate();
  }
}