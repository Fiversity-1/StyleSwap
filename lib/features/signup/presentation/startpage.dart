// startpage.dart
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 87, 87, 1),
      body: Center(
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 1,
                  child:
                      Image.asset('lib/images/backdrop.jpg', fit: BoxFit.cover),
                ),
              ),
              Positioned(
                child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Theme.of(context).primaryColor.withAlpha(240),
                      borderRadius: BorderRadius.circular(0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Cinder',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: (5.0)),
                        child: Text(
                          'Trade Clothes Online',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: (25.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(right: (30.0)),
                                  child: SizedBox(
                                    width: width * 0.35,
                                    height: height * 0.07,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/login');
                                      },
                                      child: const Text('Log in',
                                          style: TextStyle(fontSize: 24)),
                                    ),
                                  )),
                              SizedBox(
                                width: width * 0.35,
                                height: height * 0.07,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              Image.asset(
                'lib/images/hanger.png',
                height: 75,
                width: 75,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
