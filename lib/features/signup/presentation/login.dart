// signup.dart
import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _submitCreds1 = TextEditingController();
  final _submitCreds2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Expanded(
          child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.10,
              child: Image.asset('lib/images/backdrop2.jpg', fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 5, // Adjust as needed
            left: 0,
            right: 0,
            child: Image.asset(
              Provider.of<ThemeSwitcher>(context).themeData == lightTheme
                  ? 'lib/images/hanger.png'
                  : 'lib/images/hanger_white.png',
              height: 75,
              width: 75,
            ),
          ),
          Positioned(
            bottom: 15, // Adjust as needed
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not yet signed up?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextButton(
                  child: Text(
                    'Register here',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width,
              ),
              Text('Glad you\'re here!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge),
              Padding(
                padding: const EdgeInsets.only(top: (20.0), bottom: (8.5)),
                child: SizedBox(
                  height: height * 0.085,
                  width: kIsWeb ? width * 0.35 : width * 0.875,
                  child: TextField(
                    controller: _submitCreds1,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      hintText: 'Username',
                      filled: true,
                      suffix: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _submitCreds1.clear();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.085,
                width: kIsWeb ? width * 0.35 : width * 0.875,
                child: TextField(
                  controller: _submitCreds2,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    hintText: 'Password',
                    filled: true,
                    suffix: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _submitCreds2.clear();
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: (15.0)),
                child: SizedBox(
                  width: kIsWeb ? width * 0.2 : width * 0.45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/search');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
