// signup.dart
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _submitCreds = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 87, 87, 1),
      body: Center(
          child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.10,
              child: Image.asset('lib/images/backdrop2.jpg', fit: BoxFit.cover),
            ),
          ),
          Column(
            children: [
              Image.asset(
                'lib/images/hanger.png',
                height: 75,
                width: 75,
              ),
              SizedBox(
                height: height * 0.2,
                width: width,
              ),
              const Text(
                'Welcome to Cinder',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(top: (20.0), bottom: (8.5)),
                child: SizedBox(
                  height: height * 0.085,
                  width: width * 0.875,
                  child: TextField(
                    controller: _submitCreds,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(255, 87, 87, 1))),
                      hintText: 'Username',
                      filled: true,
                      fillColor: Colors.white,
                      suffix: IconButton(
                        icon: const Icon(Icons.clear),
                        color: const Color.fromRGBO(255, 87, 87, 1),
                        onPressed: () {
                          _submitCreds.clear();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.085,
                width: width * 0.875,
                child: TextField(
                  controller: _submitCreds,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(255, 87, 87, 1))),
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    suffix: IconButton(
                      icon: const Icon(Icons.clear),
                      color: const Color.fromRGBO(255, 87, 87, 1),
                      onPressed: () {
                        _submitCreds.clear();
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: (15.0)),
                child: SizedBox(
                  width: width * 0.45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: (165.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not yet signed up?',
                      style: TextStyle(fontSize: 17.5, color: Colors.white),
                    ),
                    TextButton(
                      child: const Text(
                        'Register here',
                        style: TextStyle(fontSize: 17.5, color: Colors.black),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
