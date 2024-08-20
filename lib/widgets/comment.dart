import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';

//https://pub.dev/packages/comment_box code modified from example
class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  Widget commentChild(comments) {
    return ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 0.0),
            child: Column(
              children: [
                ListTile(
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black26, width: 3),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  leading: const CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        AssetImage('lib/images/profilepicture.jpg'),
                  ),
                  title: Text(
                    comments[index].user,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(comments[index].commentContent),
                  trailing: Text(comments[index].time,
                      style: const TextStyle(fontSize: 10)),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: const CustomBottomNavBar(
          currentIndex: 2,
        ),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomTopAppBar(),
        ),
        body: Center(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: (5), top: (10)),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                iconSize: 20,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              width: width * 0.75,
              child: CommentBox(
                userImage: const AssetImage('lib/images/profilepicture.jpg'),
                labelText: 'Comment here :)',
                errorText: 'Comment cannot be blank',
                withBorder: false,
                sendButtonMethod: () {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      comments.add(Comment(
                          commentContent:
                              "Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment, Hello this is a massive comment",
                          time: "5:45pm",
                          user: "Steve",
                          picture: 'lib/images/profilepicture.jpg'));
                    });
                    commentController.clear();
                    FocusScope.of(context).unfocus();
                  }
                },
                formKey: formKey,
                commentController: commentController,
                backgroundColor: Theme.of(context).hoverColor,
                textColor: Colors.white,
                sendWidget: const Icon(Icons.send_rounded,
                    size: 30, color: Colors.white),
                child: commentChild(comments),
              ),
            ),
          ],
        )));
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
