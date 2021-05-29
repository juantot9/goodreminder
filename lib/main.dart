import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:good_reminder/models/usuario.dart';
import 'package:good_reminder/screens/wrapper.dart';
import 'package:good_reminder/servicios/auth_conf.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Usuario>.value(
      initialData: null,
      value: AuthConfigurationService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

//grupo 11
