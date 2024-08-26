class ChatListing {
  String name;
  String previewContent;
  String time;
  bool opened;
  ChatListing(
      {required this.name,
      required this.previewContent,
      required this.time,
      required this.opened});
}

List<ChatListing> inbox = [
  ChatListing(
      name: "Shaq",
      previewContent: "New Clothing Match!",
      time: "5:45pm",
      opened: true),
  ChatListing(
      name: "Steve",
      previewContent: "New Clothing Match!",
      time: "7:30pm",
      opened: false),
  ChatListing(
      name: "Bob",
      previewContent: "New Clothing Match!",
      time: "7:45pm",
      opened: true),
  ChatListing(
      name: "Karen",
      previewContent: "New Clothing Match!",
      time: "8pm",
      opened: true),
];
