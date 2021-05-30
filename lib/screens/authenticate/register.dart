import 'package:flutter/material.dart';
import 'package:good_reminder/screens/authenticate/sing_in.dart';
import 'package:good_reminder/servicios/auth_conf.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthConfigurationService _auth = AuthConfigurationService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: 

      Container(
      
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.tealAccent[200]])),
        child: Center(
          child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Introduce un email' : null,
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
                  validator: (val) => val.length < 6
                      ? 'La contraseña tiene que tener al menos 6 caracteres'
                      : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(
                  height: 30.0,
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
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth
                          .registerWhithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() {
                          error = 'Please supply a valid email';
                        });
                      } else {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => SignIn()));
                      }
                    }
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
              ],
            ),
          ),
        )),
      ),
    );
  }
}
