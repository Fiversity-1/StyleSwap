import 'package:clothing_swap/features/clothing/domain/clothing_info.dart';
import 'package:clothing_swap/features/clothing/presentation/select_preferences.dart';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:clothing_swap/features/clothing/domain/clothing_type.dart';
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
//Modified Chat GPT to convert string to enum
  FaIcon? getIconForValue(String category, String value, {double? newSize}) {
    FaIcon? originalIcon;

    switch (category.toLowerCase()) {
      case 'type':
        ClothingType? type = enumFromString(ClothingType.values, value);
        originalIcon = type != null ? clothingTypeIcons[type] : null;
        break;

      case 'colour':
        ClothingColour? colour = enumFromString(ClothingColour.values, value);
        originalIcon = colour != null ? clothingColourIcons[colour] : null;
        break;

      case 'size':
        LetteredSize? size = enumFromString(LetteredSize.values, value);
        originalIcon = size != null ? letteredSizeIcons[size] : null;
        break;

      case 'condition':
        ClothingCondition? condition =
            enumFromString(ClothingCondition.values, value);
        originalIcon =
            condition != null ? clothingConditionIcons[condition] : null;
        break;

      case 'gender':
        ClothingGender? gender = enumFromString(ClothingGender.values, value);
        originalIcon = gender != null ? clothingGenderIcons[gender] : null;
        break;

      default:
        return null;
    }
    //handle colours for colour icon
    if (originalIcon != null && category == "Colour") {
      return FaIcon(
        originalIcon.icon,
        size: 20,
        color: originalIcon.color,
      );
    }

    return originalIcon;
  }

  T? enumFromString<T>(Iterable<T> values, String value) {
    try {
      return values.firstWhere((e) =>
          e.toString().split('.').last.toLowerCase() == value.toLowerCase());
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();
    final preferencesNotifier = userManager.currentUser.preferences;

    var icon = getIconForValue(widget.category, widget.text.toLowerCase());
    return Chip(
      label: Text(widget.text == "Newwithtags"
          ? "New with tags"
          : widget.text == "Newnotags"
              ? "New no tags"
              : widget.text == "Likenew"
                  ? "Like new"
                  : widget.text == "Wellworn"
                      ? "Well worn"
                      : widget.text),
      //avatar icon lookup chatgpt
      avatar: widget.category != "Colour"
          ? FaIcon(icon!.icon,
              size: 20, color: Theme.of(context).iconTheme.color)
          : icon,

      backgroundColor:
          Theme.of(context).floatingActionButtonTheme.backgroundColor,
      labelStyle: Theme.of(context).textTheme.bodyLarge,
      deleteIcon: const Icon(Icons.close),
      onDeleted: () {
        setState(
          () {
            preferencesNotifier.removePreference(widget.category, widget.text);
          },
        );
      },
      deleteButtonTooltipMessage: '',
      //GPT for border modification
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded edges
          side: BorderSide(color: Theme.of(context).hoverColor, width: 2)),
    );
  }
}
