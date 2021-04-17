import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_firebase_auth/blocs/auth_bloc.dart';
import 'package:flutter_firebase_auth/screens/home_page.dart';
// import 'package:flutter_firebase_auth/screens/sign_up_page.dart';
// import 'package:flutter_firebase_auth/services/auth_service.dart';
import 'package:provider/provider.dart';
// import 'package:sign_button/create_button.dart';
import 'package:sign_button/sign_button.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // ignore: cancel_subscriptions
  StreamSubscription<User> loginStateSubscription;
  @override
  // ignore: must_call_super
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen(
      (fbUser) {
        if (fbUser != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton.mini(
              buttonType: ButtonType.google,
              onPressed: () => authBloc.loginGoogle(),
            ),
          ],
        ),
      ),
    );
  }
}

// class SignInPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextField(
//             controller: emailController,
//             keyboardType: TextInputType.emailAddress,
//             decoration: InputDecoration(
//               labelText: 'Email',
//               hintText: 'Enter your email',
//             ),
//           ),
//           TextField(
//             controller: passwordController,
//             obscureText: true,
//             keyboardType: TextInputType.visiblePassword,
//             decoration: InputDecoration(
//               labelText: 'Password',
//               hintText: 'Enter your password',
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: () {
//                   context.read<AuthenticationServices>().signIn(
//                         email: emailController.text,
//                         password: passwordController.text,
//                       );
//                 },
//                 child: Text('Login'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SignUpPage(),
//                     ),
//                   );
//                 },
//                 child: Text('Sign Up'),
//               ),
//             ],
//           ),
//           SignInButton.mini(buttonType: ButtonType.google, onPressed: () {})
//         ],
//       ),
//     );
//   }
// }
