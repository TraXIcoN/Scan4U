import 'package:scan4u/Model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scan4u/shared/globals.dart' as globals;
import 'package:scan4u/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //creating user object based on firebase user
  User? _userFromFirebaseUser(FirebaseUser user) {
    if (user != null) {
      globals.userid = user.uid;
    }
    return user != null ? User(uid: user.uid) : null;
  }

  /*  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  } */

  // Sign in anonymously
  Future signinAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      globals.userid = user.uid;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      await DataBaseService(uid: user.uid)
          .updateUserData(globals.uploadedFileURL, globals.finalName);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future databaseIntegrate() async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    print(user.uid);
    //create a new document for the user with the uid
    await DataBaseService(uid: uid)
        .updateUserData(globals.uploadedFileURL, globals.finalName);
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
