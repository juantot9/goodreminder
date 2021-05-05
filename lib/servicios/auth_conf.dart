import 'package:firebase_auth/firebase_auth.dart';

class AuthConfigurationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInAnon() async {
    try {
      UserCredential res = await _auth.signInAnonymously();
      User user = res.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
