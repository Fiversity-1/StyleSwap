class Comment {
  final String commentContent;
  final String time;
  final String user;
  final String picture;
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
