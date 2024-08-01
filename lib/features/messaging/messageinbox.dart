// signup.dart
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 87, 87, 1),
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 2,
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: (10.0)),
            child: Text(
              'Chats',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView(
              children: List.generate(
                25,
                (index) => ListTile(
                  minTileHeight: 85,
                  horizontalTitleGap: 20,
                  onTap: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                  hoverColor: const Color.fromRGBO(255, 87, 87, 1),
                  splashColor: const Color.fromRGBO(255, 87, 87, 1),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                        color: Color.fromRGBO(255, 87, 87, 1), width: 0.5),
                  ),
                  title: Text('Person $index',
                      style: Theme.of(context).textTheme.headlineSmall),
                  tileColor: Colors.white,
                  subtitle: Text('Random Subject text here...',
                      style: Theme.of(context).textTheme.bodyMedium),
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('lib/images/person.png'),
                  ),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: [
                      Text('Time',
                          style: Theme.of(context).textTheme.bodySmall),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
