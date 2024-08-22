// signup.dart
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Message extends StatefulWidget {
  const Message({super.key, required this.title});
  final String title;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
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
                //Slideable example modified from https://pub.dev/packages/flutter_slidable
                (index) => Slidable(
                  // Key from chatgpt
                  key: ValueKey(inbox[index]),

                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    dismissible: DismissiblePane(
                      onDismissed: () {
                        setState(() {
                          inbox.removeAt(index);
                        });
                      },
                    ),
                    // All actions are defined in the children parameter.
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          setState(() {
                            inbox.removeAt(index);
                          });
                        },
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        icon: Icons.person,
                        label: 'Block',
                      ),
                      Visibility(
                        visible: !inbox[index].opened,
                        child: SlidableAction(
                          onPressed: (context) {
                            setState(() {
                              inbox[index].opened = true;
                            });
                          },
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          icon: Icons.mark_chat_read,
                          label: 'Mark as Read',
                        ),
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          setState(() {
                            inbox.removeAt(index);
                          });
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),

                  child: ListTile(
                    minTileHeight: 85,
                    minVerticalPadding: 12.5,
                    horizontalTitleGap: 20,
                    selected: !inbox[index].opened,
                    selectedTileColor: Theme.of(context).cardColor,
                    onTap: () {
                      inbox[index].opened = true;
                      Navigator.pushNamed(context, '/chat');
                    },
                    hoverColor: Theme.of(context).primaryColor.withAlpha(240),
                    splashColor: Theme.of(context).primaryColor.withAlpha(240),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Theme.of(context).primaryColor.withAlpha(240),
                          width: 0.5),
                    ),
                    title: Row(
                      children: [
                        Text('${inbox[index].name} ',
                            style: const TextStyle(
                              fontSize: 24,
                            )),
                        Icon(!inbox[index].opened
                            ? Icons.mark_chat_unread
                            : null),
                      ],
                    ),
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
      opened: true),
  ChatListing(
      name: "Karen",
      previewContent: "New Clothing Match!",
      time: "8pm",
      opened: true),
];
