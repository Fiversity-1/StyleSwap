import 'package:image_picker/image_picker.dart';

class ChatMessage {
  final String messageContent;
  final String messageType;
  final String time;
  XFile? images;
  //Image
  ChatMessage(
      {required this.messageContent,
      required this.messageType,
      required this.time,
      this.images});
}

List<ChatMessage> messages = [
  ChatMessage(
      messageContent: "Hey are you keen on trading?",
      messageType: "receiver",
      time: "5:45pm"),
];
