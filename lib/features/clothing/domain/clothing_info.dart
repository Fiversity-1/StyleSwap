
import 'package:image_picker/image_picker.dart';

import 'clothing_type.dart';

class ClothingInfo {
  final List<XFile> images;
  final ClothingSize? size;
  final String? description;
  final String? brand;
  final ClothingCondition? condition;
  final ClothingGender? gender;
  final ClothingType? type;
  final List<ClothingColour>? colours;

  ClothingInfo({this.images = const [], this.size, this.description,
    this.brand, this.condition, this.gender, this.type, this.colours});

  ClothingInfo copyWith({
    List<XFile>? images,
    ClothingSize? size,
    String? description,
    String? brand,
    ClothingCondition? condition,
    ClothingGender? gender,
    ClothingType? type,
    List<ClothingColour>? colours,}) {
    return ClothingInfo(size: size ?? this.size, images: images ?? this.images,
      description: description ?? this.description, brand: brand ?? this.brand,
      condition: condition ?? this.condition, gender: gender ?? this.gender,
      type: type ?? this.type, colours: colours ?? this.colours);
  }
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

enum ClothingCondition with DatabaseRepresentationMapper {
  newWithTags,
  newNoTags,
  likeNew,
  worn,
  wellWorn;

  @override
  String getDatabaseRepresentation() {
    return toString().split('.').last;
  }
}

enum ClothingGender with DatabaseRepresentationMapper  {
  male,
  female,
  unisex;

  @override
  String getDatabaseRepresentation() {
    return toString().split('.').last;
  }
}

sealed class ClothingSize with DatabaseRepresentationMapper {
  const ClothingSize();
}

class LetteredSizing extends ClothingSize with DatabaseRepresentationMapper {
  const LetteredSizing(this.size);

  final LetteredSize size;

  @override
  String toString() {
    return size.toString();
  }

  @override
  String getDatabaseRepresentation() {
    return size.getDatabaseRepresentation();
  }
}

enum LetteredSize with DatabaseRepresentationMapper {
  xxs,
  xs,
  s,
  m,
  l,
  xl,
  xxl;

  @override
  String toString() {
    return getSizeUpper();
  }

  @override
  String getDatabaseRepresentation() {
    return getSizeUpper();
  }

  String getSizeUpper() {
    return toString().split('.').last.toUpperCase();
  }
}

class NumericalSizing extends ClothingSize with DatabaseRepresentationMapper {
  const NumericalSizing(this.size, this.system);

  final int size;
  final SizingSystem system;

  @override
  String toString() {
    return '$size (${system.toString().split('.').last.toUpperCase()})';
  }

  @override
  String getDatabaseRepresentation() {
    return '$size:${system
        .toString()
        .split('.')
        .last
        .toUpperCase()}';
  }
}

enum SizingSystem {
  eu,
  uk,
  us
}

enum ClothingColour with DatabaseRepresentationMapper {
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
  brown;

  @override
  String getDatabaseRepresentation() {
    return toString().split('.').last;
  }
}

mixin DatabaseRepresentationMapper {
  String getDatabaseRepresentation();
}
