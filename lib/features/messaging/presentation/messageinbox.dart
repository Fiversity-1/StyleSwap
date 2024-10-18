import 'package:clothing_swap/features/messaging/domain/chat_listing_class.dart';
import 'package:clothing_swap/theme/gradient.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

//Display Message Inbox of User
class Message extends StatefulWidget {
  const Message({super.key, required this.title});

  final String title;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  String truncateWithEllipsis(String text, int length) {
    if (text.length <= length) {
      return text;
    } else {
      return '${text.substring(0, length - 1)}...';
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatManager = Provider.of<ChatManager>(context);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                children: List.generate(chatManager.chats.length,
                    //Slideable example modified from https://pub.dev/packages/flutter_slidable
                    //Slider for mark as read, block and delete
                    (index) {
                  final chat = chatManager.chats[index];
                  return Slidable(
                    //GPT was used for the following reasons:
                    //Prompt: "I am doing a message inbox UI with a list view,
                    //how do I stop changes happening to all tiles, and treat
                    //them separately?"
                    key: ValueKey(chat),

                    endActionPane: ActionPane(
                      motion: const StretchMotion(),
                      extentRatio: 0.75,
                      // A pane can dismiss the Slidable.

                      // All actions are defined in the children parameter.
                      children: [
                        Visibility(
                          visible: !chat.opened,
                          child: SlidableAction(
                            onPressed: (context) {
                              //GPT was used for the following reasons:
                              //Prompt: "How can I add a delay in flutter to prevent setState being called too early"
                              Future.delayed(
                                const Duration(milliseconds: 200),
                                () {
                                  setState(() {
                                    chatManager.setChatOpened(chat.id, true,
                                        chat.previewContent, "5:45pm");
                                  });
                                },
                              );
                            },
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            icon: Icons.mark_chat_read,
                            label: 'Read',
                          ),
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            setState(() {
                              chatManager.removeChat(chat.id);
                            });
                          },
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          icon: Icons.person,
                          label: 'Block',
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            setState(() {
                              chatManager.removeChat(chat.id);
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
                      selected: !chat.opened,
                      selectedTileColor: Theme.of(context).cardColor,
                      onTap: () {
                        chatManager.selectChat(chat.id);
                        Navigator.pushNamed(context, '/chat');
                      },
                      hoverColor: Theme.of(context).primaryColor.withAlpha(240),
                      splashColor:
                          Theme.of(context).primaryColor.withAlpha(240),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color:
                                Theme.of(context).primaryColor.withAlpha(240),
                            width: 0.5),
                      ),
                      title: Row(
                        children: [
                          Text(
                              truncateWithEllipsis(
                                  chat.name, !chat.opened ? 13 : 14),
                              style: const TextStyle(
                                fontSize: 24,
                              )),
                          SizedBox(width: !chat.opened ? 10 : 0),
                          Icon(!chat.opened ? Icons.mark_chat_unread : null),
                        ],
                      ),
                      subtitle: Text(chat.previewContent,
                          style: Theme.of(context).textTheme.bodyMedium),
                      leading: CircleAvatar(
                        backgroundImage: chat.image,
                      ),
                      trailing: Wrap(
                        spacing: 6, // space between two icons
                        children: [
                          Text(chat.time,
                              style: Theme.of(context).textTheme.bodyMedium),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
