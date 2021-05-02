import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset('images/logo.png',
              height: 100.0,
              ),
            ),
            SizedBox(height: 15.0,),
             _userTextField(),
            SizedBox(height: 15.0,),
             _passwordTextField(),
            SizedBox(height: 20.0,),
             _buttonLogin(),
            ],
          ),
        )
      ),
    );
  }

  Widget _userTextField() {
    return StreamBuilder(
      builder:(BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrogeno',
            ), 
            onChanged: (value){

            },
          ),
        );
      } 
    );
  }

  Widget _passwordTextField() {
    return StreamBuilder(
      builder:(BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              hintText: 'Contraseña',
              labelText: 'Contraseña',
            ), 
            onChanged: (value){

            },
          ),
        );
      } 
    );
  }
  

  Widget _buttonLogin() {
    return StreamBuilder(
      builder:(BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Iniciar Sesion'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: (){},
        );
      } 
    );
  }
   
}