import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

//https://pub.dev/packages/comment_box code modified from example
class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  CommentsState createState() => CommentsState();
}

class CommentsState extends State<Comments> {
  final _sendComment = TextEditingController();
  final _scroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomTopAppBar(),
        ),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: (10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Clothing Swap - Brisbane",
                      style: kIsWeb
                          ? Theme.of(context).textTheme.headlineMedium
                          : Theme.of(context).textTheme.headlineSmall),
                ],
              ),
            ),
            Padding(
              padding: kIsWeb
                  ? const EdgeInsets.only(left: (5), top: (10))
                  : const EdgeInsets.only(left: (5), top: (5)),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                iconSize: 20,
                onPressed: () {
                  Navigator.pushNamed(context, '/events');
                },
              ),
            ),
            Center(
                child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: kIsWeb
                      ? const EdgeInsets.only(top: (20.0))
                      : const EdgeInsets.only(top: (30.0)),
                  child: SizedBox(
                    width: kIsWeb ? width * 0.8 : width * 0.9,
                    height: height * 0.65,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: width * 0.65,
                        child: ListView.builder(
                            reverse: true,
                            controller: _scroller,
                            shrinkWrap: true,
                            //physics from chatGPT
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              bool like = false;
                              bool angry = false;
                              bool haha = false;
                              bool heart = false;
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
                                    // trailing: Text(comments[index].time),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(comments[index].commentContent),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            LikeButton(
                                              size: 20,
                                              isLiked: like,
                                              likeCountPadding:
                                                  const EdgeInsets.all(10),
                                              likeCount: comments[index].like,
                                              likeBuilder: (like) {
                                                final colour = like
                                                    ? Colors.blue
                                                    : Theme.of(context)
                                                        .indicatorColor;
                                                return Icon(Icons.thumb_up,
                                                    color: colour);
                                              },
                                            ),
                                            LikeButton(
                                              size: 20,
                                              isLiked: heart,
                                              likeCountPadding:
                                                  const EdgeInsets.all(10),
                                              likeCount: comments[index].heart,
                                              likeBuilder: (heart) {
                                                final colour = heart
                                                    ? Colors.red
                                                    : Theme.of(context)
                                                        .indicatorColor;
                                                return Icon(Icons.favorite,
                                                    color: colour);
                                              },
                                            ),
                                            LikeButton(
                                              size: 20,
                                              isLiked: haha,
                                              likeCountPadding:
                                                  const EdgeInsets.all(10),
                                              likeCount: comments[index].haha,
                                              likeBuilder: (haha) {
                                                final colour = haha
                                                    ? Colors.yellowAccent
                                                    : Theme.of(context)
                                                        .indicatorColor;
                                                return Icon(
                                                    Icons
                                                        .sentiment_very_satisfied_rounded,
                                                    color: colour);
                                              },
                                            ),
                                            LikeButton(
                                              size: 20,
                                              likeCountPadding:
                                                  const EdgeInsets.all(10),
                                              isLiked: angry,
                                              likeCount: comments[index].angry,
                                              likeBuilder: (angry) {
                                                final colour = angry
                                                    ? Colors.red
                                                    : Theme.of(context)
                                                        .indicatorColor;
                                                return Icon(
                                                    Icons
                                                        .sentiment_dissatisfied_rounded,
                                                    color: colour);
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    )),
                              );
                            }),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: (20.0)),
                  child: SizedBox(
                    height: height * 0.075,
                    width: width * 0.8,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.top,
                      controller: _sendComment,
                      decoration: InputDecoration(
                        //contentPadding from chatgpt
                        contentPadding: kIsWeb
                            ? const EdgeInsets.all(20.0)
                            : const EdgeInsets.only(top: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: (10.0), right: 10),
                          child: CircleAvatar(
                            radius: 16,
                            backgroundImage:
                                AssetImage('lib/images/profilepicture.jpg'),
                          ),
                        ),
                        hintText: 'Comment Here...',
                        filled: true,

                        suffix: IconButton(
                          icon: const Icon(Icons.send, size: 24),
                          onPressed: () {
                            setState(() => _sendComment.text.isNotEmpty
                                ? comments.add(
                                    Comment(
                                      commentContent: _sendComment.text,
                                      time: "Now",
                                      user: "Steve",
                                      picture: 'lib/images/profilepicture.jpg',
                                      like: 0,
                                      heart: 0,
                                      haha: 0,
                                      angry: 0,
                                      angryed: false,
                                      hahaed: false,
                                      liked: false,
                                      hearted: false,
                                    ),
                                  )
                                : null);
                            _sendComment.clear();
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
              ]),
            )),
          ],
        ));
  }
}

class Comment {
  String commentContent;
  String time;
  String user;
  String picture;
  int like;
  int heart;
  int haha;
  bool liked;
  bool hearted;
  bool hahaed;
  bool angryed;

  int angry;
  //Image
  Comment({
    required this.commentContent,
    required this.time,
    required this.user,
    required this.picture,
    required this.like,
    required this.heart,
    required this.haha,
    required this.angry,
    required this.angryed,
    required this.hahaed,
    required this.hearted,
    required this.liked,
  });
}

List<Comment> comments = [
  Comment(
    commentContent:
        "What if there was a massive message that took over two lines two liens two liens two lines two liens",
    time: "Now",
    user: "Steve",
    picture: 'lib/images/profilepicture.jpg',
    like: 5,
    heart: 6,
    haha: 7,
    angry: 3,
    angryed: false,
    hahaed: false,
    liked: false,
    hearted: false,
  ),
  Comment(
    commentContent: "So Keen!",
    time: "Now",
    user: "Steve",
    picture: 'lib/images/profilepicture.jpg',
    like: 5,
    heart: 6,
    haha: 7,
    angry: 3,
    angryed: false,
    hahaed: false,
    liked: false,
    hearted: false,
  ),
  Comment(
    commentContent: "So Keen!",
    time: "Now",
    user: "Steve",
    picture: 'lib/images/profilepicture.jpg',
    like: 5,
    heart: 6,
    haha: 7,
    angry: 3,
    angryed: false,
    hahaed: false,
    liked: false,
    hearted: false,
  ),
];
