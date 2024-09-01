import 'package:clothing_swap/features/clothing/domain/clothing_info.dart';
import 'package:clothing_swap/features/clothing/presentation/preferences_provider.dart';
import 'package:clothing_swap/features/clothing/presentation/select_preferences.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Tag extends StatefulWidget {
  const Tag({super.key, required this.text, required this.category, t});
  final String text;
  final String category;

  @override
  TagState createState() => TagState();
}

class TagState extends State<Tag> {
  Map<Enum, FaIcon> _pickCatgory(String option) {
    switch (option) {
      case "Type":
        return clothingTypeIcons;
      case "Size":
        return letteredSizeIcons;
      case "Condition":
        return clothingConditionIcons;
      case "Colour":
        return clothingColourIcons;
      case "Gender":
        return clothingGenderIcons;
    }
    return clothingColourIcons;
  }

//Chat GPT to convert string to enum
  ClothingType? clothingTypeFromString(String type) {
    try {
      return ClothingType.values
          .firstWhere((e) => e.toString().split('.').last == type);
    } catch (e) {
      return null; // Return null if the type is not found
    }
  }

  @override
  Widget build(BuildContext context) {
    final preferencesNotifier = context.watch<PreferencesNotifier>();

    ClothingType? icon = clothingTypeFromString(widget.text.toLowerCase());
    return Chip(
      label: Text(widget.text),
      //avatar icon lookup chatgpt
      avatar: clothingTypeIcons[icon] ??
          const FaIcon(FontAwesomeIcons.question, size: 20),

      backgroundColor: Theme.of(context).primaryColor,
      labelStyle: Theme.of(context).textTheme.bodyLarge,
      deleteIcon: const Icon(Icons.close),
      onDeleted: () {
        preferencesNotifier.removePreference(widget.category, widget.text);
      },
      deleteButtonTooltipMessage: '',
      //GPT for border modification
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded edges
          side: BorderSide(color: Theme.of(context).hoverColor, width: 3)),
    );
  }
}
