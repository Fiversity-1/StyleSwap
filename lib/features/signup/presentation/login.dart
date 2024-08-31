// signup.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';



class Login extends StatefulWidget {
  final String title; 

  const Login({super.key, required this.title}); 

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> { 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), 
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _signInWithGoogle, 
          //onPressed: () {
          //  Navigator.pushNamed(context, '/personal_profile');
          //},
          child: const Text('Login with Google'),
        ),
      ),
    );
  }


  Future<void> _signInWithGoogle() async {
    print('Sign in with Google executing');

    final googleProvider = GoogleAuthProvider();

    try {
      await FirebaseAuth.instance.signInWithPopup(googleProvider);
      //Navigator.pushNamed(context, '/personal_profile');
    } on FirebaseException catch (e) {

      print('Error signing in with Google');
      print(e.message);
    } 
  }
}
