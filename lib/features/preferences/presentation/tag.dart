import 'package:clothing_swap/features/clothing/domain/clothing_info.dart';
import 'package:clothing_swap/features/preferences/presentation/select_preferences.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Tag represents a single search preference tag
class Tag extends StatefulWidget {
  const Tag({
    super.key,
    required this.text,
    required this.category,
    //GPT suggested using callback for updating after tag removed
    required this.onDeleted,
  });
  final String text;
  final String category;
  //GPT suggested using callback for updating after tag removed
  final VoidCallback onDeleted;

  @override
  TagState createState() => TagState();
}

class TagState extends State<Tag> {
//getIconForValue has been modified by GPT to convert string to enum
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
      // GPT recommended using this approach for finding the correct icon to use
      avatar: widget.category != "Colour"
          ? FaIcon(icon != null ? icon.icon : Icons.error,
              size: 20, color: Theme.of(context).iconTheme.color)
          : icon,

      backgroundColor:
          Theme.of(context).floatingActionButtonTheme.backgroundColor,
      labelStyle: Theme.of(context).textTheme.bodyLarge,
      deleteIcon: const Icon(Icons.close),
      //GPT suggested using callback for updating after tag removed
      onDeleted: () {
        widget.onDeleted();
      },
      deleteButtonTooltipMessage: '',
      //GPT was used for border modification of colour and rounded edges
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Theme.of(context).hoverColor, width: 2)),
    );
  }
}
