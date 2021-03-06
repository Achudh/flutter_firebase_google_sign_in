import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_auth/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthBloc {
  final firebaseAuth = FirebaseAuth.instance;
  final authService = AuthenticationServices();
  final googleSignin = GoogleSignIn(scopes: ['email']);

  Stream<User> get currentUser => authService.currentUser;

  loginGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignin.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      //Firebase Sign in
      final result = await authService.signInWithUserCredentials(credential);

      print('${result.user.displayName}');
    } catch (error) {
      print(error);
    }
  }

  logout() {
    authService.signOut();
  }
}
