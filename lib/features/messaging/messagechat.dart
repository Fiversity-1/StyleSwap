// signup.dart
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';

class MessageChat extends StatefulWidget {
  const MessageChat({super.key, required this.title});

  final String title;
  @override
  State<MessageChat> createState() => _MessageChatState();
}

class _MessageChatState extends State<MessageChat> {
  final _sendText = TextEditingController();
  final _scroller = ScrollController();
  @override
  Widget build(BuildContext context) {
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
                      iconSize: 35,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/message');
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('lib/images/profilepicture.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: (15), top: 5),
                    child: Text('Steve',
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
              //https://www.freecodecamp.org/news/build-a-chat-app-ui-with-flutter/ modified
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: height * 0.074),
                  child: ListView.builder(
                    itemCount: messages.length,
                    shrinkWrap: true,
                    controller: _scroller,

                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    //physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 10, bottom: 10),
                        child: Align(
                            alignment:
                                (messages[index].messageType == "receiver"
                                    ? Alignment.topLeft
                                    : Alignment.topRight),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (messages[index].messageType ==
                                            "receiver"
                                        ? Colors.purple
                                        : Colors.blue),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    messages[index].messageContent,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(messages[index].time),
                              ],
                            )),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    height: height * 0.075,
                    width: width * 0.9,
                    child: TextField(
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      controller: _sendText,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Aa',
                        filled: true,
                        prefix: IconButton(
                            icon: const Icon(Icons.image), onPressed: () {}),
                        suffix: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            setState(() => messages.add(ChatMessage(
                                messageContent: "test",
                                messageType: "sender",
                                time: "5:45pm")));
                            _sendText.clear();
                            _scroller.animateTo(
                              _scroller.position.maxScrollExtent + 90,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 500),
                            );
                          },
                        ),
                      ),
                    ),
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
