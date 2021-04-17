import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/blocs/auth_bloc.dart';
import 'package:flutter_firebase_auth/screens/home_page.dart';
import 'package:flutter_firebase_auth/screens/sign_in_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Root());
}

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<AuthBloc>(context);
    if (firebaseUser != null) {
      return HomePage();
    }
    return SignInPage();
  }
}
