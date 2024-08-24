// signup.dart

import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:provider/provider.dart';

class MessageChat extends StatefulWidget {
  const MessageChat({super.key, required this.title, this.clothingFile});
  final String? clothingFile;
  final String title;
  @override
  State<MessageChat> createState() => _MessageChatState();
}

class _MessageChatState extends State<MessageChat> {
  final _sendText = TextEditingController();
  final _scroller = ScrollController();

//Void function idea to handle  both onSubmitted: and onPressed (icon) from chatGPT
//code modified for personal implementation
  void _handleSend(String value) {
    setState(() => _sendText.text.isNotEmpty
        ? messages.add(ChatMessage(
            messageContent: _sendText.text,
            messageType: "sender",
            time: "5:45pm"))
        : null);
    _sendText.clear();
    _scroller.animateTo(
      _scroller.position.maxScrollExtent + 90,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    final clothingFile = ModalRoute.of(context)?.settings.arguments;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: (10.0), top: 5),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      iconSize: 25,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/message');
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage:
                          AssetImage('lib/images/profilepicture.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: (15), top: 5),
                    child: Text('Steve',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center),
                  ),
                ],
              ),

              //https://www.freecodecamp.org/news/build-a-chat-app-ui-with-flutter/ retrieved from the following URL but modified for our application
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: height * 0.074),
                  child: ListView.builder(
                      //item count + 1 from chatgpt
                      itemCount: messages.length + 1,
                      shrinkWrap: true,
                      controller: _scroller,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      itemBuilder: (context, index) {
                        //Chat Gpt code - the idea to include the picture in the list view
                        //and to increase index

                        if (index == 0) {
                          // Return the image as the first item
                          return Column(
                            children: [
                              clothingFile != null
                                  ? ClipOval(
                                      child: Image.asset(
                                        clothingFile.toString(),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipOval(
                                      child: Image.asset(
                                        'lib/images/1.jpg',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ],
                          );
                        } else {
                          //End chat GPT code
                          return Container(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 10, bottom: 10),
                            child: Align(
                                alignment: (messages[index - 1].messageType ==
                                        "receiver"
                                    ? Alignment.topLeft
                                    : Alignment.topRight),
                                child: Column(
                                  crossAxisAlignment:
                                      messages[index - 1].messageType ==
                                              "receiver"
                                          ? CrossAxisAlignment.start
                                          : CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:
                                            Provider.of<ThemeSwitcher>(context)
                                                        .themeData ==
                                                    lightTheme
                                                ? (messages[index - 1]
                                                            .messageType ==
                                                        "receiver"
                                                    ? Colors.green
                                                    : Colors.blue)
                                                : (messages[index - 1]
                                                            .messageType ==
                                                        "receiver"
                                                    ? Colors.purple
                                                    : Colors.blue),
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        messages[index - 1].messageContent,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      messages[index - 1].time,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ],
                                )),
                          );
                        }
                      }),
                ),
              )
            ],
          ),
          //End code retrieved
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          icon: const Icon(Icons.image),
                          iconSize: 25,
                          onPressed: () async {
                            // Handle select from camera roll action
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                          height: kIsWeb ? height * 0.075 : height * 0.055,
                          width: width * 0.8,
                          child: TextField(
                            onSubmitted: _handleSend,
                            onTap: () {},
                            textAlignVertical: TextAlignVertical.top,
                            controller: _sendText,
                            decoration: InputDecoration(
                              //contentPadding from chatgpt
                              contentPadding: kIsWeb
                                  ? const EdgeInsets.all(20.0)
                                  : const EdgeInsets.only(top: 10, left: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'Aa',
                              filled: true,
                              suffix: IconButton(
                                icon: const Icon(Icons.send,
                                    size: kIsWeb ? 24 : 18),
                                onPressed: () {
                                  //Idea from chatgpt to handle both enter and icon
                                  _handleSend(_sendText.text);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChatMessage {
  String messageContent;
  String messageType;
  String time;
  //Image
  ChatMessage(
      {required this.messageContent,
      required this.messageType,
      required this.time});
}

List<ChatMessage> messages = [
  ChatMessage(
      messageContent: "Hello this is a massive message",
      messageType: "receiver",
      time: "5:45pm"),
  ChatMessage(messageContent: "Hello", messageType: "receiver", time: "5:45pm"),
  ChatMessage(messageContent: "Hello", messageType: "sender", time: "5:45pm"),
  ChatMessage(messageContent: "Hello", messageType: "receiver", time: "5:45pm"),
  ChatMessage(messageContent: "Hello", messageType: "sender", time: "5:45pm"),
];
