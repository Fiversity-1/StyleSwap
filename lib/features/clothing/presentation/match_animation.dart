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
      backgroundColor: Theme.of(context).primaryColor,
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
            Container(
              width: width * 0.6,
              height: height * 0.6,
              child: Lottie.network(
                  'https://lottie.host/185e81d7-c6ae-47f3-bb7b-0b37a92f69bf/WNOrVcmrIv.json'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/chat');
              },
              child: const Text('Send a message!'),
            ),
          ],
        ),
      ),
    );
  }
}
