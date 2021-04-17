import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<User> get currentUser => _firebaseAuth.authStateChanges();
  // ignore: missing_return
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

// ignore: missing_return
  Future<String> signUp({String email, String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signInWithUserCredentials(
          AuthCredential credential) async =>
      await _firebaseAuth.signInWithCredential(credential);

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
