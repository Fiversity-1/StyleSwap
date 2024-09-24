import 'package:clothing_swap/features/clothing/presentation/preferences_provider.dart';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:clothing_swap/widgets/tag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//PreferenceRow is a list of "tag" widgets with a text widget used for each
//search preference (i.e. condition)
class PreferenceRow extends StatefulWidget {
  const PreferenceRow({super.key, required this.category});
  final String category;

  @override
  PreferenceRowState createState() => PreferenceRowState();
}

class PreferenceRowState extends State<PreferenceRow> {
  List<String>? _selectPreferences(PreferencesNotifier preferencesNotifier) {
    switch (widget.category) {
      case "Type":
        return preferencesNotifier.getPreferences("Type");
      case "Size":
        return preferencesNotifier.getPreferences("Size");
      case "Colour":
        return preferencesNotifier.getPreferences("Colour");
      case "Condition":
        return preferencesNotifier.getPreferences("Condition");
      case "Gender":
        return preferencesNotifier.getPreferences("Gender");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    //GPT used for tracking preference changes via provider
    final userManager = context.watch<UserManager>();
    final preferencesNotifier = userManager.currentUser.preferences;

    List<String>? preferences = _selectPreferences(preferencesNotifier);

    //Generate tags for each specific category
    List<Widget> tags = [];

    for (int i = 0; i < preferences!.length; i++) {
      tags.add(Tag(
        text: preferences[i],
        category: widget.category,
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
