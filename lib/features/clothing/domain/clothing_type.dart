import 'package:clothing_swap/features/clothing/domain/clothing_info.dart';
import 'package:flutter/material.dart';

import '../../../widgets/selection_tree_grid.dart';

enum ClothingType with IconMapper, DatabaseRepresentationMapper {
  hat,
  scarf,
  tie,
  shirt,
  midriff,
  belt,
  shorts,
  pants,
  skirt,
  dress,
  shoes,
  jumper,
  jacket,
  sweater,
  coat,
  gloves,
  vest,
  leggings,
  glasses,
  tights;

  @override
  IconData getIcon() {
    switch (this) {
      case ClothingType.hat:
        return Icons.question_answer;
      case ClothingType.scarf:
        return Icons.scale;
      case ClothingType.tie:
        return Icons.send_time_extension;
      default:
        return Icons.help;
    }
  }

  @override
  String toString() {
    switch (this) {
      default:
        return capitalizeWords(super.toString().split('.').last);
    }
  }

  @override
  String getDatabaseRepresentation() {
    return toString().split('.').last;
  }

  static List<SelectionTreeItem<ClothingType>> getTree() {
    return [
      const SelectionNode(
          label: "Female", icon: Icons.question_mark,
          children: [
            SelectionNode(
                label: "Top",
                icon: Icons.question_mark,
                children: [
                  SelectionItem(shirt),
                  SelectionItem(midriff),
                  SelectionItem(dress),
                  SelectionItem(tie),
                  SelectionItem(jumper),
                  SelectionItem(jacket),
                  SelectionItem(sweater),
                  SelectionItem(coat),
                  SelectionItem(vest),
                  SelectionItem(scarf)
                ]
            ),
            SelectionNode(
                label: "Bottom",
                icon: Icons.question_mark,
                children: [
                  SelectionItem(shorts),
                  SelectionItem(pants),
                  SelectionItem(leggings),
                  SelectionItem(tights),
                  SelectionItem(skirt),
                  SelectionItem(dress),
                  SelectionItem(belt),
                  SelectionItem(shoes),
                ]
            ),
            SelectionNode(
                label: "Accessories",
                icon: Icons.question_mark,
                children: [
                  SelectionItem(hat),
                  SelectionItem(scarf),
                  SelectionItem(tie),
                  SelectionItem(belt),
                  SelectionItem(shoes),
                  SelectionItem(glasses),
                ]
            )
          ]
      ),
      const SelectionNode(
          label: "Male", icon: Icons.question_mark,
          children: [
            SelectionNode(
                label: "Top",
                icon: Icons.question_mark,
                children: [
                  SelectionItem(shirt),
                  SelectionItem(tie),
                  SelectionItem(jumper),
                  SelectionItem(jacket),
                  SelectionItem(sweater),
                  SelectionItem(coat),
                  SelectionItem(vest),
                  SelectionItem(scarf)
                ]
            ),
            SelectionNode(
                label: "Bottom",
                icon: Icons.question_mark,
                children: [
                  SelectionItem(shorts),
                  SelectionItem(pants),
                  SelectionItem(leggings),
                  SelectionItem(tights),
                  SelectionItem(belt),
                  SelectionItem(shoes),
                ]
            ),
            SelectionNode(
                label: "Accessories",
                icon: Icons.question_mark,
                children: [
                  SelectionItem(hat),
                  SelectionItem(scarf),
                  SelectionItem(tie),
                  SelectionItem(belt),
                  SelectionItem(shoes),
                  SelectionItem(glasses),
                ]
            )
          ]
      ),
    ];
  }
}

mixin IconMapper {
  IconData getIcon();
}

String capitalizeWords(String text) {
  if (text.isEmpty) return text;
  return text.split(' ').map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}