import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MatchAnimation extends StatefulWidget {
  const MatchAnimation({super.key});

  @override
  State<MatchAnimation> createState() => _MatchAnimationState();
}

class _MatchAnimationState extends State<MatchAnimation> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text(
                'It\'s a match!',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: width * 0.6,
              height: height * 0.6,
              child: Lottie.asset('lib/images/match3.json'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: ElevatedButton(
                    child: const Text(
                      'Keep Looking',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/swipe');
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                  child: const Text(
                    'Message',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
