import 'package:flutter/material.dart';
import 'package:good_reminder/models/usuario.dart';
import 'package:good_reminder/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<Usuario>(context); //Puede que de fallos por algo anterior.
    print(user);
    
    //DEvolvemos Home o Autenticacion.
    return Authenticate();
  }
}