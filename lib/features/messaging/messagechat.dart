// signup.dart
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';

class MessageChat extends StatelessWidget {
  const MessageChat({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 87, 87, 1),
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 1,
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: (10.0)),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: 35,
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
              const CircleAvatar(
                backgroundImage: AssetImage('lib/images/person.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: (15.0)),
                child: Text('Steve',
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center),
              ),
            ],
          )
        ],
      ),
    );
  }
}
