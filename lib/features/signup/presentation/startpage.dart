// startpage.dart
// import 'package:clothing_swap/theme/theme.dart';
// import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(right: (30.0)),
                                  child: SizedBox(
                                    width: kIsWeb ? width * 0.175 : width * 0.3,
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
                                width: kIsWeb ? width * 0.175 : width * 0.35,
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
              Padding(
                padding: const EdgeInsets.only(top: (15.0)),
                child: Image.asset(
                  'lib/images/hanger_white.png',
                  height: 75,
                  width: 75,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
