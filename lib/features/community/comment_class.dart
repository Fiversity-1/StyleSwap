//Comment class with 3 example comments
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
    commentContent: "This looks really good!",
    time: "5:45 pm",
    user: "Steve",
    picture: 'lib/images/profilepicture.jpg',
    like: 5,
    heart: 6,
    haha: 1,
    angry: 0,
    angryed: false,
    hahaed: false,
    liked: false,
    hearted: false,
  ),
  Comment(
    commentContent: "Yeah I'm keen as to go",
    time: "5:51 pm",
    user: "Steve",
    picture: 'lib/images/jacob.jpg',
    like: 1,
    heart: 28,
    haha: 0,
    angry: 0,
    angryed: false,
    hahaed: false,
    liked: false,
    hearted: false,
  ),
];
