class ChatMessage {
  String messageContent;
  String messageType;
  String time;
  //Image
  ChatMessage(
      {required this.messageContent,
      required this.messageType,
      required this.time});
}

List<ChatMessage> messages = [
  ChatMessage(
      messageContent: "Hello this is a massive message",
      messageType: "receiver",
      time: "5:45pm"),
  ChatMessage(messageContent: "Hello", messageType: "receiver", time: "5:45pm"),
  ChatMessage(messageContent: "Hello", messageType: "sender", time: "5:45pm"),
  ChatMessage(messageContent: "Hello", messageType: "receiver", time: "5:45pm"),
  ChatMessage(messageContent: "Hello", messageType: "sender", time: "5:45pm"),
];
