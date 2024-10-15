import 'package:clothing_swap/theme/gradient.dart';
import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../profile/data/profile_api.dart';
import '../../profile/presentation/profile_class.dart';

//Log in page
class StartPage extends StatelessWidget {
  const StartPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SizedBox(
            height: height,
            width: width,
            child: Positioned(
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'StyleSwap',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: (5.0)),
                      child: Text(
                        'Trade Clothes Online',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: (25.0)),
                      child: Column(
                        children: [
                          SizedBox(
                            width: kIsWeb ? width * 0.175 : width * 0.3,
                            height: height * 0.07,
                            //Google Authentication via firebase
                            child: ElevatedButton(
                              onPressed: () {
                                _signInWithGoogle(context);
                              },
                              child: const Text('Log in',
                                  style: TextStyle(fontSize: 24)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        //Select logo based on colour scheme
        appBar: AppBar(
          title: Center(
            child: Image.asset(
              Provider.of<ThemeSwitcher>(context).themeData == lightTheme
                  ? 'lib/images/hanger.png'
                  : 'lib/images/hanger_white.png',
              height: 65,
              width: 75,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    final userManager = Provider.of<UserManager>(context, listen: false);

    if (kDebugMode) {
      print("we have pressed the sign in button");
    }
    try {
      if (kIsWeb) {
        // Web sign-in
        await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
      } else {
        if (kDebugMode) {
          print("are we there yet");
        }
        final googleUser = await GoogleSignIn().signIn();
        if (kDebugMode) {
          print("0");
        }
        if (googleUser != null) {
          if (kDebugMode) {
            print("1");
          }
          final googleAuth = await googleUser.authentication;
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          if (kDebugMode) {
            print("22222222222222222222222222222222");
          }
          await FirebaseAuth.instance.signInWithCredential(credential);
        }
      }

      if (FirebaseAuth.instance.currentUser == null) {
        return;
      }

      if (!context.mounted) return;

      // if the user is registered, take them to the swipe page
      // otherwise take them to the new_profile page.
      if (await isUserRegistered()) {
        userManager.switchUser(Profile.fromUser(FirebaseAuth.instance.currentUser!));

        Navigator.pushNamedAndRemoveUntil(context,
            '/swipe', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context,
            '/new_profile',
                (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    } on Error {
      debugPrint("Error happened somewhere");
    }
  }
}
