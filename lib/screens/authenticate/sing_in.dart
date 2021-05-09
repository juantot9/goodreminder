import 'package:flutter/material.dart';
import 'package:good_reminder/servicios/auth_conf.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

String email= '';
String password= '';

class _SignInState extends State<SignIn> {
  final AuthConfigurationService _auth = AuthConfigurationService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.tealAccent[200]])),
            child: Center(
              child: Column(
                children: [
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
                  _userTextField(),
                  SizedBox(
                    height: 30.0,
                  ),
                  _passwordTextField(),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buttonLogin(),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buttonRegister(),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buttonUnregister(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon(Icons.email),
            hintText: 'ejemplo@correo.com',
            labelText: 'Correo electrónico',
          ),
          onChanged: (value) {
            setState(()=>email=value);
          },
        ),
      );
    });
  }

  Widget _passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
          ),
          onChanged: (value) {
            setState(()=>password=value);
          },
        ),
      );
    });
  }

  Widget _buttonLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(250, 50),
        ),
        child: Container(
          //  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Iniciar sesión'),
        ),
        onPressed: ()  async{
          print(password);
          print(email);
        },
      );
    });
  }

  Widget _buttonRegister() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(250, 50),
        ),
        child: Container(
          //  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Registrarse'),
        ),
        onPressed: () {},
      );
    });
  }

  Widget _buttonUnregister() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
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
          }
        },
      );
    });
  }
}
