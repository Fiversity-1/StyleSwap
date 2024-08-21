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
          Expanded(
            child: ListView(
              children: List.generate(
                inbox.length,
                (index) => ListTile(
                  minTileHeight: 85,
                  minVerticalPadding: 12.5,
                  horizontalTitleGap: 20,
                  onTap: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                  hoverColor: Theme.of(context).primaryColor.withAlpha(240),
                  splashColor: Theme.of(context).primaryColor.withAlpha(240),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).primaryColor.withAlpha(240),
                        width: 0.5),
                  ),
                  //inbox[index].opened
                  title:
                      Text(inbox[index].name, style: TextStyle(fontSize: 24)),
                  subtitle: Text(inbox[index].previewContent,
                      style: Theme.of(context).textTheme.bodyMedium),
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('lib/images/1.jpg'),
                  ),
                  trailing: Wrap(
                    spacing: 18, // space between two icons
                    children: [
                      Text(inbox[index].time,
                          style: Theme.of(context).textTheme.bodyMedium),
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

class ChatListing {
  String name;
  String previewContent;
  String time;
  bool opened;
  ChatListing(
      {required this.name,
      required this.previewContent,
      required this.time,
      required this.opened});
}

List<ChatListing> inbox = [
  ChatListing(
      name: "Jacob",
      previewContent: "New Clothing Match!",
      time: "5:45pm",
      opened: true),
  ChatListing(
      name: "Steve",
      previewContent: "New Clothing Match!",
      time: "7:30pm",
      opened: false),
  ChatListing(
      name: "Bob",
      previewContent: "New Clothing Match!",
      time: "7:45pm",
      opened: false),
  ChatListing(
      name: "Karen",
      previewContent: "New Clothing Match!",
      time: "8pm",
      opened: true),
];
