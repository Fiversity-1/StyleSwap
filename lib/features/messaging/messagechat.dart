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
      //boo
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
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.075,
                width: MediaQuery.of(context).size.width * 0.95,
                child: TextField(
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  controller: _sendText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.blue)),
                    hintText: 'Aa',
                    filled: true,
                    fillColor: Colors.white,
                    suffix: IconButton(
                      icon: const Icon(Icons.send),
                      color: Colors.blue,
                      onPressed: () {
                        _sendText.clear();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
