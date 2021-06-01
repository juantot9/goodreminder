import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:good_reminder/models/usuario.dart';
import 'package:good_reminder/screens/authenticate/sing_in.dart';
import 'package:good_reminder/servicios/database.dart';
import 'package:path/path.dart';

class AuthConfigurationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Usuario _userFromFirebaseUser(User user) {
    return user != null ? Usuario(uid: user.uid) : null;
  }

  Stream<Usuario> get user {
    //El metodo que tenemos V estaba obsoleto
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  //Registro anonimo
  Future signInAnon() async {
    try {
      UserCredential res = await _auth
          .signInAnonymously(); //AuthResult esta obsoleto ahora se usa UserCredentials
      User user = res.user; //FirebaseUser esta obsoleto ahora se usa User
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in con email y contraseña
  Future singInWhithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Registro con email y contraseña
  Future registerWhithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      await DatabaseService(uid: user.uid).createUserData(
          0,
          'new user',
          DateTime.now(),
          DateTime.now(),
          0,
          DateTime.now()); //fecha formato yyyy-MM-dd hh:mm:ss
      //int id, String titulo, DateTime created, DateTime updated, int status(0 o 1), DateTime dateTodo

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Singout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
