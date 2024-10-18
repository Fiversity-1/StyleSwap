import 'package:clothing_swap/features/preferences/presentation/tag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//PreferenceRow is a list of "tag" widgets with a text widget used for each
//search preference (i.e. condition)
class PreferenceRow<T> extends StatefulWidget {
  const PreferenceRow(
      {super.key,
      required this.category,
      required this.preferences,
      required this.onDelete});

  final String category;
  final List<T> preferences;
  final void Function(int) onDelete;

  @override
  PreferenceRowState createState() => PreferenceRowState<T>();
}

class PreferenceRowState<T> extends State<PreferenceRow> {
  @override
  Widget build(BuildContext context) {
    //Generate tags for each specific category
    List<Widget> tags = [];

    for (int i = 0; i < widget.preferences.length; i++) {
      tags.add(Tag(
        text: widget.preferences[i].toString(),
        category: widget.category,
        //GPT was used for the following reasons:
        //Prompt: "How to use a callback to track state changes when a widget
        //is removed in flutter"
        onDeleted: () {
          widget.onDelete(i);
          // Notify the parent to rebuild
        },
      ));
    }
    //"Add" tag at the end of each list tag list
    tags.add(
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/add_clothes_preferences',
              arguments: widget.category);
        },
        //GPT used to increase touchable area whilst keeping icon size small.
        child: Chip(
          labelPadding: const EdgeInsets.all(0),
          label: const SizedBox(
            width: 24, // Increase touchable area
            height: 24,
            child: Icon(
              Icons.add,
              size: 24,
            ),
          ),
          backgroundColor: Theme.of(context).hoverColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: BorderSide(
              color: Theme.of(context).hoverColor,
              width: 3,
            ),
          ),
        ),
      ),
    );

    return Padding(
        padding: const EdgeInsets.only(left: (25.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: (5.0), bottom: 15),
              child: Row(
                children: [
                  Text(widget.category,
                      style: kIsWeb
                          ? Theme.of(context).textTheme.headlineSmall
                          : Theme.of(context).textTheme.headlineSmall)
                ],
              ),
            ),
            Wrap(spacing: 10, runSpacing: 10, children: tags),
          ],
        ));
  }
}
