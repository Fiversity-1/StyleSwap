import 'package:flutter/material.dart';

class Tag extends StatefulWidget {
  const Tag({super.key, required this.text});
  final String text;

  @override
  TagState createState() => TagState();
}

class TagState extends State<Tag> {
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(widget.text),
      backgroundColor: Theme.of(context).primaryColor,
      labelStyle: Theme.of(context).textTheme.bodyLarge,
      deleteIcon: const Icon(Icons.close),
      onDeleted: () {},
      deleteButtonTooltipMessage: '',
      //GPT for border modification

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded edges
          side: BorderSide(color: Theme.of(context).hoverColor, width: 3)),
    );
  }
}
