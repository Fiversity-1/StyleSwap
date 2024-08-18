// signup.dart

import 'package:clothing_swap/features/community/eventlist.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';

class IndividualEvent extends StatefulWidget {
  const IndividualEvent({super.key, this.individualEvent});
  final Event? individualEvent;
  @override
  State<IndividualEvent> createState() => _IndividualEventState();
}

class _IndividualEventState extends State<IndividualEvent> {
  final _sendComment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
      body: Center(
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: (20.0)),
            child: SizedBox(
              width: width * 0.85,
              //height: height * 0.5,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                          hoverColor: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          onTap: () {},
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    'lib/images/vinnies.jpg',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  ' ${events[index].title}',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          minTileHeight: 125,
                          titleAlignment: ListTileTitleAlignment.threeLine,
                          subtitle: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Hosted By: ${events[index].company}'),
                                  Text(
                                      'When: ${events[index].date}, ${events[index].time}'),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(events[index].details),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 50,
                                width: width * 0.65,
                                child: TextField(
                                  scrollPhysics:
                                      const NeverScrollableScrollPhysics(),
                                  controller: _sendComment,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    hintText: 'Comment',
                                    filled: true,
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.only(
                                          right: 15.0, left: 15),
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'lib/images/profilepicture.jpg'),
                                      ),
                                    ),
                                    suffix: IconButton(
                                      icon: const Icon(Icons.send),
                                      onPressed: () {
                                        setState(() => comments.add(Comment(
                                            commentContent: "test",
                                            time: "5:45pm",
                                            user: "Jacob")));
                                        _sendComment.clear();
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: (338.0)),
            child: SizedBox(
              width: width * 0.85,
              child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      hoverColor: Colors.transparent,
                      onTap: () {},
                      leading: const CircleAvatar(
                        radius: 15,
                        backgroundImage:
                            AssetImage('lib/images/profilepicture.jpg'),
                      ),
                      title: Text(comments[index].user),
                      subtitle: Text(comments[index].commentContent),
                    );
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}

class Comment {
  String commentContent;
  String time;
  String user;
  //Image
  Comment(
      {required this.commentContent, required this.time, required this.user});
}

List<Comment> comments = [
  Comment(
      commentContent:
          "Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment",
      time: "5:45pm",
      user: "Steve"),
  Comment(
      commentContent: "Hello this is a massive comment",
      time: "5:45pm",
      user: "Steve"),
  Comment(
      commentContent: "Hello this is a massive comment",
      time: "5:45pm",
      user: "Steve"),
  Comment(
      commentContent: "Hello this is a massive comment",
      time: "5:45pm",
      user: "Steve")
];
