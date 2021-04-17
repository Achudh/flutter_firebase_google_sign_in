import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/blocs/auth_bloc.dart';
import 'package:flutter_firebase_auth/screens/sign_in_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<User> loginStateSubscription;
  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SignInPage(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<AuthBloc>(context);
    return Scaffold(
      body: Center(
        child: StreamBuilder<User>(
            stream: firebaseUser.currentUser,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data.displayName,
                    style: TextStyle(fontSize: 35),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      snapshot.data.photoURL.replaceFirst('s96', 's400'),
                    ),
                    radius: 60,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      firebaseUser.authService.signOut();
                    },
                    child: Text('Sign Out'),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
