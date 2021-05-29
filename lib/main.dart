import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:good_reminder/models/usuario.dart';
import 'package:good_reminder/screens/wrapper.dart';
import 'package:good_reminder/servicios/auth_conf.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark//Iconos en negro, usar light para iconos en blanco
  ));//Para cambiar la barra de estado(la barra de la bateria y la hora)
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Usuario>.value(
      initialData: null,
      value: AuthConfigurationService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}

//grupo 11
