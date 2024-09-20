import 'package:image_picker/image_picker.dart';

//ClothingInfo Class and Enums for each category
class ClothingInfo {
  final List<XFile> images;
  final ClothingSize? size;
  final String? description;
  final String? brand;
  final ClothingCondition? condition;
  final ClothingGender? gender;
  final ClothingType? type;
  final List<ClothingColour>? colours;

  ClothingInfo(
      {this.images = const [],
      this.size,
      this.description,
      this.brand,
      this.condition,
      this.gender,
      this.type,
      this.colours});

  ClothingInfo copyWith({
    List<XFile>? images,
    ClothingSize? size,
    String? description,
    String? brand,
    ClothingCondition? condition,
    ClothingGender? gender,
    ClothingType? type,
    List<ClothingColour>? colours,
  }) {
    return ClothingInfo(
        size: size ?? this.size,
        images: images ?? this.images,
        description: description ?? this.description,
        brand: brand ?? this.brand,
        condition: condition ?? this.condition,
        gender: gender ?? this.gender,
        type: type ?? this.type,
        colours: colours ?? this.colours);
  }
}

enum ClothingType {
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
}

enum Style {
  contemporary,
  naughties,
  nineties,
  eighties,
  seventies,
  sixties,
  fifties,
  vintage
}

enum ClothingCondition { newWithTags, newNoTags, likeNew, worn, wellWorn }

enum ClothingCategory { top, bottom, accessories }

enum ClothingGender { male, female, unisex }

sealed class ClothingSize {
  const ClothingSize();
}

class LetteredSizing extends ClothingSize {
  const LetteredSizing(this.size);

  final LetteredSize size;

  @override
  String toString() {
    return size.toString().split('.').last.toUpperCase();
  }
}

enum LetteredSize {
  xxs,
  xs,
  s,
  m,
  l,
  xl,
  xxl,
}

class NumericalSizing extends ClothingSize {
  const NumericalSizing(this.size, this.system);

  final int size;
  final SizingSystem system;

  @override
  String toString() {
    return '$size (${system.toString().split('.').last.toUpperCase()})';
  }
}

enum SizingSystem { eu, uk, us }

enum ClothingColour {
  red,
  green,
  lightBlue,
  darkBlue,
  purple,
  pink,
  orange,
  yellow,
  white,
  black,
  lightGrey,
  darkGrey,
  brown
}
