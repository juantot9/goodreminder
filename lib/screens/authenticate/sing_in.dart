import 'package:flutter/material.dart';
import 'package:good_reminder/screens/authenticate/register.dart';
import 'package:good_reminder/screens/home/home.dart';
import 'package:good_reminder/servicios/auth_conf.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthConfigurationService _auth = AuthConfigurationService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.tealAccent[200]])),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'images/logo.png',
                    height: 200.0,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Introduce un Email' : null,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'ejemplo@correo.com',
                    labelText: 'Correo electrónico',
                  ),
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Contraseña',
                    labelText: 'Contraseña',
                  ),
                  validator: (val) =>
                      val.length < 6 ? 'Introduce una contraseña valida' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 50),
                  ),
                  child: Container(
                    //  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                    child: Text('Iniciar sesión'),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.singInWhithEmailAndPassword(
                          email, password);

                      if (result == null) {
                        setState(() {
                          error = 'Email o Contraseña no validos';
                        });
                      } else {
                        print('entrando');
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Home()));
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 50),
                  ),
                  child: Container(
                    //  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                    child: Text('Registrarse'),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[500],
                    minimumSize: const Size(250, 50),
                  ),
                  child: Container(
                    //  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),

                    child: Text('Entrar sin registro'),
                  ),
                  onPressed: () async {
                    dynamic result = await _auth.signInAnon();
                    if (result == null) {
                      print('Error al entrar de forma anónima');
                    } else {
                      print('Accediendo de forma anónima correctamente ' +
                          result.toString());
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Home()));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
