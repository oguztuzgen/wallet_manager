import 'package:wallet_manager/model/wallet_manager_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  WMUser _fromFirebaseUser(UserCredential user) {
    return user != null ? WMUser(userID: user.user.uid) : null;
  }

  Future<dynamic> signInEmailPassword(String email, String password) async {
    var result;
    try {
      result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      UserCredential firebaseUser = result.user;
      return [_fromFirebaseUser(firebaseUser), null];
    } catch (e) {
      return [null, e];
    }
  }
  
  Future<dynamic> registerEmailPassword(String email, String password) async {
    var result;
    try {
      result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      UserCredential firebaseUser = result.user;
      return [_fromFirebaseUser(firebaseUser), null];
    } catch (e) {
      print(e.toString());
      return [null, e];
    }
  }

  Future<dynamic> logOutEmailPassword(String email, String password) async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      print(e.toString());
      return e;
    }
  }
}