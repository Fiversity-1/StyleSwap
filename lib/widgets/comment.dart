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

  void _handleReaction(String value, int index) {
    setState(() {
      var lastReaction;
      if (comments[index].angryed) {
        lastReaction = "angry";
      } else if (comments[index].hahaed) {
        lastReaction = "haha";
      } else if (comments[index].hearted) {
        lastReaction = "heart";
      } else if (comments[index].liked) {
        lastReaction = "like";
      }

      switch (value) {
        case "like":
          //2 lines chatgpt (same logic for each reaction)
          comments[index].liked = !comments[index].liked;
          comments[index].like += comments[index].liked ? 1 : -1;
          break;
        case "heart":
          comments[index].hearted = !comments[index].hearted;
          comments[index].heart += comments[index].hearted ? 1 : -1;
          break;
        case "haha":
          comments[index].hahaed = !comments[index].hahaed;
          comments[index].haha += comments[index].hahaed ? 1 : -1;
          break;
        case "angry":
          comments[index].angryed = !comments[index].angryed;
          comments[index].angry += comments[index].angryed ? 1 : -1;
          break;
      }
      if (lastReaction != value) {
        switch (lastReaction) {
          case "like":
            comments[index].liked = !comments[index].liked;
            comments[index].like -= 1;
            break;
          case "heart":
            comments[index].hearted = !comments[index].hearted;
            comments[index].heart -= 1;
            break;
          case "haha":
            comments[index].hahaed = !comments[index].hahaed;
            comments[index].haha -= 1;
            break;
          case "angry":
            comments[index].angryed = !comments[index].angryed;
            comments[index].angry -= 1;
            break;
        }
      }
    });
  }

  void _handleComment(String value) {
    setState(() => _sendComment.text.isNotEmpty
        ? comments.add(
            Comment(
              commentContent: value,
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
          )
        : null);
    _sendComment.clear();
    //scroll animation not working
    // _scroller.animateTo(
    //   _scroller.position.minScrollExtent,
    //   curve: Curves.easeOut,
    //   duration: const Duration(milliseconds: 500),
    //);
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    iconSize: 20,
                    onPressed: () {
                      Navigator.pushNamed(context, '/events');
                    },
                  ),
                  Text("Clothing Swap - Brisbane",
                      style: kIsWeb
                          ? Theme.of(context).textTheme.bodyLarge
                          : Theme.of(context).textTheme.bodyLarge),
                ],
              ),

              //https://www.freecodecamp.org/news/build-a-chat-app-ui-with-flutter/ retrieved from the following URL but modified for our application
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: height * 0.075),
                  child: SizedBox(
                    width: kIsWeb ? width * 0.6 : width * 0.9,
                    height: height * 0.65,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: width * 0.6,
                        child: ListView.builder(
                            reverse: true,
                            controller: _scroller,
                            shrinkWrap: true,

                            //physics line  from chatGPT
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shadowColor: Theme.of(context).hoverColor,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Theme.of(context).hoverColor,
                                      width: 0.9),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ListTile(
                                    key: ValueKey(comments[index]),
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
                                              isLiked: comments[index].liked,
                                              onTap: (isLiked) async {
                                                _handleReaction("like", index);

                                                return comments[index].liked;
                                              },
                                              likeCountPadding:
                                                  const EdgeInsets.all(10),
                                              likeCount: comments[index].like,
                                              likeBuilder: (isLiked) {
                                                final colour = isLiked
                                                    ? Colors.blue
                                                    : null;
                                                return Icon(
                                                    Icons.thumb_up_outlined,
                                                    color: colour);
                                              },
                                            ),
                                            LikeButton(
                                              size: 20,
                                              isLiked: comments[index].hearted,
                                              onTap: (isLiked) async {
                                                _handleReaction("heart", index);

                                                return comments[index].hearted;
                                              },
                                              likeCountPadding:
                                                  const EdgeInsets.all(10),
                                              likeCount: comments[index].heart,
                                              likeBuilder: (isLiked) {
                                                final colour =
                                                    isLiked ? Colors.red : null;
                                                return Icon(
                                                    Icons.favorite_outline,
                                                    color: colour);
                                              },
                                            ),
                                            LikeButton(
                                              size: 20,
                                              isLiked: comments[index].hahaed,
                                              onTap: (isLiked) async {
                                                _handleReaction("haha", index);

                                                return comments[index].hahaed;
                                              },
                                              likeCountPadding:
                                                  const EdgeInsets.all(10),
                                              likeCount: comments[index].haha,
                                              likeBuilder: (isLiked) {
                                                final colour = isLiked
                                                    ? Colors.green
                                                    : null;
                                                return Icon(
                                                    Icons
                                                        .sentiment_very_satisfied_rounded,
                                                    color: colour);
                                              },
                                            ),
                                            LikeButton(
                                              size: 20,
                                              onTap: (isLiked) async {
                                                _handleReaction("angry", index);

                                                return comments[index].angryed;
                                              },
                                              likeCountPadding:
                                                  const EdgeInsets.all(10),
                                              isLiked: comments[index].angryed,
                                              likeCount: comments[index].angry,
                                              likeBuilder: (isLiked) {
                                                final colour =
                                                    isLiked ? Colors.red : null;
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
              ),
            ],
          ),
          //End code retrieved
          Padding(
            padding: EdgeInsets.only(bottom: height * 0.025),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: height * 0.075,
                    width: kIsWeb ? width * 0.6 : width * 0.9,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.top,
                      controller: _sendComment,
                      onSubmitted: _handleComment,
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
                            if (_sendComment.text.isNotEmpty) {
                              _handleComment(_sendComment.text);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
