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
  @override
  Widget build(BuildContext context) {
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
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.075,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: TextField(
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      controller: _sendText,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Aa',
                        filled: true,
                        suffix: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            _sendText.clear();
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
