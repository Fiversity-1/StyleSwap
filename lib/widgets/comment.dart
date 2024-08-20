import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';

//https://pub.dev/packages/comment_box code modified from example
class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  CommentsState createState() => CommentsState();
}

class CommentsState extends State<Comments> {
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
        body: Stack(
          children: [
            Center(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: (20.0)),
                  child: SizedBox(
                    width: width * 0.8,
                    height: height * 0.7,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: width * 0.65,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Theme.of(context).primaryColor,
                                shadowColor: Theme.of(context).hoverColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ListTile(
                                  tileColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onTap: () {},
                                  leading: const CircleAvatar(
                                    radius: 15,
                                    backgroundImage: AssetImage(
                                        'lib/images/profilepicture.jpg'),
                                  ),
                                  title: Text(comments[index].user),
                                  trailing: Text(comments[index].time),
                                  subtitle:
                                      Text(comments[index].commentContent),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ));
  }
}

class Comment {
  String commentContent;
  String time;
  String user;
  String picture;
  //Image
  Comment(
      {required this.commentContent,
      required this.time,
      required this.user,
      required this.picture});
}

List<Comment> comments = [
  Comment(
      commentContent: "So Keen!",
      time: "Now",
      user: "Steve",
      picture: 'lib/images/profilepicture.jpg'),
  Comment(
      commentContent: "So Keen!",
      time: "Now",
      user: "Steve",
      picture: 'lib/images/profilepicture.jpg'),
  Comment(
      commentContent: "So Keen!",
      time: "Now",
      user: "Steve",
      picture: 'lib/images/profilepicture.jpg'),
  Comment(
      commentContent: "So Keen!",
      time: "Now",
      user: "Steve",
      picture: 'lib/images/profilepicture.jpg'),
  Comment(
      commentContent: "So Keen!",
      time: "Now",
      user: "Steve",
      picture: 'lib/images/profilepicture.jpg'),
  Comment(
      commentContent: "So Keen!",
      time: "Now",
      user: "Steve",
      picture: 'lib/images/profilepicture.jpg'),
  Comment(
      commentContent: "So Keen!",
      time: "Now",
      user: "Steve",
      picture: 'lib/images/profilepicture.jpg'),
  Comment(
      commentContent: "So Keen!",
      time: "Now",
      user: "Steve",
      picture: 'lib/images/profilepicture.jpg'),
  Comment(
      commentContent:
          "Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment",
      time: "5:45pm",
      user: "Steve",
      picture: 'lib/images/profilepicture.jpg'),
  Comment(
      commentContent:
          "Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment",
      time: "5:45pm",
      user: "Steve",
      picture: 'lib/images/profilepicture.jpg'),
  Comment(
      commentContent:
          "Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment",
      time: "5:45pm",
      user: "Steve",
      picture: 'lib/images/profilepicture.jpg'),
];
