import 'package:clothing_swap/features/community/comment_class.dart';
import 'package:clothing_swap/theme/gradient.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

//https://pub.dev/packages/comment_box general template of comments and
//comment bar inspired by this example. Package was not used.
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
      String lastReaction = "";
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
          //GPT used for tracking state of like count and liked state
          //Same code applied for each reation.
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

  //Add a fixed comment for testing purposes, animate to top of listview
  void _handleComment(String value) {
    setState(() => _sendComment.text.isNotEmpty
        ? comments.add(
            Comment(
              commentContent: value,
              time: "Now",
              user: "Steve",
              picture: 'lib/images/noProfilePicture.png',
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
    myFocusNode.requestFocus();
    _scroller.animateTo(0,
        curve: Curves.easeOut, duration: const Duration(milliseconds: 500));
  }

  final FocusNode myFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomTopAppBar(),
        ),
        //Unfocus keyboard when screen pressed
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          onLongPress: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
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
                              : Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),

                  //https://www.freecodecamp.org/news/build-a-chat-app-ui-with-flutter/
                  //General template of comments and comment bar inspired by this example.
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: height * 0.1),
                      child: SizedBox(
                        width: kIsWeb ? width * 0.6 : width * 0.95,
                        height: height * 0.65,
                        child: SingleChildScrollView(
                          controller: _scroller,
                          child: SizedBox(
                            width: width * 0.6,
                            child: ListView.builder(
                                reverse: true,
                                shrinkWrap: true,

                                //GPT used for NeverScrollableSCrollPhysics
                                //Used to prevent scrolling of whole page
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.white, width: 0.5),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    //Unfocus keyboard when comment is tapped
                                    child: GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                      },
                                      onDoubleTap: () {
                                        FocusScope.of(context).unfocus();
                                      },
                                      child: ListTile(
                                        key: ValueKey(comments[index]),
                                        tileColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        onTap: () {},
                                        title: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 15,
                                              backgroundImage: AssetImage(
                                                  comments[index].picture),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                comments[index].user,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 7.5),
                                              child: Text(
                                                "• ${comments[index].time}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(comments[index]
                                                    .commentContent),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    //Row of reactions
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        //https://pub.dev/packages/like_button
                                                        //Inspired by like button example, used throughout
                                                        LikeButton(
                                                          size: 20,
                                                          isLiked:
                                                              comments[index]
                                                                  .liked,
                                                          onTap:
                                                              (isLiked) async {
                                                            _handleReaction(
                                                                "like", index);

                                                            return comments[
                                                                    index]
                                                                .liked;
                                                          },
                                                          likeCountPadding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          likeCount:
                                                              comments[index]
                                                                  .like,
                                                          likeBuilder:
                                                              (isLiked) {
                                                            final colour =
                                                                isLiked
                                                                    ? Colors
                                                                        .blue
                                                                    : null;
                                                            return Icon(
                                                                Icons
                                                                    .thumb_up_outlined,
                                                                color: colour);
                                                          },
                                                        ),
                                                        LikeButton(
                                                          size: 20,
                                                          isLiked:
                                                              comments[index]
                                                                  .hearted,
                                                          onTap:
                                                              (isLiked) async {
                                                            _handleReaction(
                                                                "heart", index);

                                                            return comments[
                                                                    index]
                                                                .hearted;
                                                          },
                                                          likeCountPadding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          likeCount:
                                                              comments[index]
                                                                  .heart,
                                                          likeBuilder:
                                                              (isLiked) {
                                                            final colour =
                                                                isLiked
                                                                    ? Colors.red
                                                                    : null;
                                                            return Icon(
                                                                Icons
                                                                    .favorite_outline,
                                                                color: colour);
                                                          },
                                                        ),
                                                        LikeButton(
                                                          size: 20,
                                                          isLiked:
                                                              comments[index]
                                                                  .hahaed,
                                                          onTap:
                                                              (isLiked) async {
                                                            _handleReaction(
                                                                "haha", index);

                                                            return comments[
                                                                    index]
                                                                .hahaed;
                                                          },
                                                          likeCountPadding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          likeCount:
                                                              comments[index]
                                                                  .haha,
                                                          likeBuilder:
                                                              (isLiked) {
                                                            final colour =
                                                                isLiked
                                                                    ? Colors
                                                                        .green
                                                                    : null;
                                                            return Icon(
                                                                Icons
                                                                    .sentiment_very_satisfied_rounded,
                                                                color: colour);
                                                          },
                                                        ),
                                                        LikeButton(
                                                          size: 20,
                                                          onTap:
                                                              (isLiked) async {
                                                            _handleReaction(
                                                                "angry", index);

                                                            return comments[
                                                                    index]
                                                                .angryed;
                                                          },
                                                          likeCountPadding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          isLiked:
                                                              comments[index]
                                                                  .angryed,
                                                          likeCount:
                                                              comments[index]
                                                                  .angry,
                                                          likeBuilder:
                                                              (isLiked) {
                                                            final colour =
                                                                isLiked
                                                                    ? Colors.red
                                                                    : null;
                                                            return Icon(
                                                                Icons
                                                                    .sentiment_dissatisfied_rounded,
                                                                color: colour);
                                                          },
                                                        ),
                                                      ],
                                                    )),
                                              ],
                                            )),
                                      ),
                                    ),
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
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: SizedBox(
                  height: height * 0.075,
                  child: TextField(
                    focusNode: myFocusNode,
                    textAlignVertical: TextAlignVertical.top,
                    controller: _sendComment,
                    onSubmitted: _handleComment,
                    decoration: InputDecoration(
                      //GPT used for fill colour of input comment box
                      fillColor: Theme.of(context).primaryColor,
                      //GPT used for inner content padding
                      contentPadding: kIsWeb
                          ? const EdgeInsets.all(20.0)
                          : const EdgeInsets.only(top: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: (10.0), right: 10),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundImage:
                              AssetImage('lib/images/noProfilePicture.png'),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
