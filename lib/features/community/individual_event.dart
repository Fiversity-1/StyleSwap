// signup.dart

import 'package:clothing_swap/features/community/event_class.dart';
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
    //Event arg = ModalRoute.of(context)!.settings.arguments as Event;
    Event arg = Event(
        company: 'Jacob',
        logo: Icons.category,
        details: 'Bring hats!',
        title: 'Clothes Swap',
        date: '4/5/24',
        time: '5pm',
        location: '17 River Street, Brisbane',
        city: "Brisbane",
        attendance: 4);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: (20.0)),
              child: SizedBox(
                width: width * 0.7,
                //height: height * 0.5,
                child: ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                            hoverColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black26, width: 3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            onTap: () {},
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('lib/images/op.jpg',
                                      fit: BoxFit.fitWidth),
                                  Text(
                                    '${arg.title} - ${arg.city}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            minTileHeight: 125,
                            titleAlignment: ListTileTitleAlignment.threeLine,
                            subtitle: Column(
                              children: [
                                ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(0),
                                  children: [
                                    ListTile(
                                      shape: const RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.black26, width: 0.5),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(0),
                                        ),
                                      ),
                                      title: Text(
                                        'Hosted by: ${arg.company}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      leading: const Icon(Icons.home),
                                    ),
                                    ListTile(
                                      shape: const RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.black26, width: 0.5),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(0),
                                        ),
                                      ),
                                      title: Text(
                                        "Where: ${arg.location}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      leading: const Icon(Icons.location_on),
                                    ),
                                    ListTile(
                                      shape: const RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.black26, width: 0.5),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(0),
                                        ),
                                      ),
                                      title: Text(
                                        "When: ${arg.date}, ${arg.time} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      leading: const Icon(
                                          Icons.calendar_month_rounded),
                                    ),
                                    ListTile(
                                      shape: const RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.black26, width: 0.5),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(0),
                                        ),
                                      ),
                                      title: Text(
                                        "Details: ${arg.details}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      leading: const Icon(Icons.info),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Attending: ${arg.attendance}"),
                                        IconButton(
                                          icon: const Icon(
                                              Icons.check_circle_outline),
                                          iconSize: 25,
                                          onPressed: () {
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.comment),
                                      iconSize: 25,
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/events');
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
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
                                          radius: 15,
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
                        Padding(
                          padding: const EdgeInsets.only(top: (0.0)),
                          child: SizedBox(
                            width: width * 0.85,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black26, width: 0.5),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    hoverColor: Colors.transparent,
                                    onTap: () {},
                                    leading: const CircleAvatar(
                                      radius: 15,
                                      backgroundImage: AssetImage(
                                          'lib/images/profilepicture.jpg'),
                                    ),
                                    title: Text(comments[index].user),
                                    trailing: const Text('4pm'),
                                    subtitle:
                                        Text(comments[index].commentContent),
                                  );
                                }),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ]),
        ),
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
