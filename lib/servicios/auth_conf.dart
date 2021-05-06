
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_reminder/models/usuario.dart';

class AuthConfigurationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Usuario _userFromFirebaseUser(User user){
    return user!=null ? Usuario(uid: user.uid) : null;
  }

  Stream<Usuario> get user{ 
    //El metodo que tenemos V estaba obsoleto
    return _auth.authStateChanges().map((User user) => _userFromFirebaseUser(user));
  }


  Future signInAnon() async {
    try {
      UserCredential res = await _auth.signInAnonymously();
      User user = res.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}
