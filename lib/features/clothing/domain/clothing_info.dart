import 'package:flutter/foundation.dart';
import 'package:string_extensions/string_extensions.dart';

import '../data/clothing_api.dart';

/// ClothingInfo Class and Enums for each category
class ClothingInfo {
  final String? id;
  final List<Uint8List> images;
  final ClothingSize? size;
  final String? description;
  final String? brand;
  final ClothingCondition? condition;
  final ClothingGender? gender;
  final ClothingType? type;
  final List<ClothingColour>? colours;
  final String? user;
  final String? userId;
  final double? distance;

  ClothingInfo(
      {this.images = const [],
      this.size,
      this.description,
      this.brand,
      this.condition,
      this.gender,
      this.type,
      this.colours,
      this.user,
      this.userId,
      this.distance,
      this.id});

  // Copy the current data with the provided modifications.
  ClothingInfo copyWith(
      {List<Uint8List>? images,
      ClothingSize? size,
      String? description,
      String? brand,
      ClothingCondition? condition,
      ClothingGender? gender,
      ClothingType? type,
      List<ClothingColour>? colours,
      String? user,
      String? userId,
      double? distance,
      String? id}) {
    return ClothingInfo(
        size: size ?? this.size,
        images: images ?? this.images,
        description: description ?? this.description,
        brand: brand ?? this.brand,
        condition: condition ?? this.condition,
        gender: gender ?? this.gender,
        type: type ?? this.type,
        colours: colours ?? this.colours,
        user: user ?? this.user,
        userId: userId ?? this.userId,
        distance: distance ?? this.distance,
        id: id ?? this.id);
  }
}

// Converts an api response to the clothingInfo class.
Future<List<ClothingInfo>> convertApiResponseToClothingInfo(
    dynamic apiResponse) async {
  return await Future.wait(
    (apiResponse as List).map((item) async {
      try {
        return ClothingInfo(
          id: item['clothingId'].toString(),
          size: item['size'] != null
              ? ClothingSize.fromDatabaseRepresentation(item['size'])
              : null,
          description: item['bio'],
          condition: item['condition'] != null
              ? ClothingCondition.fromDatabaseRepresentation(item['condition'])
              : null,
          gender: item['gender'] != null
              ? ClothingGender.fromDatabaseRepresentation(item['gender'])
              : null,
          type: item['type'] != null
              ? ClothingType.fromDatabaseRepresentation(item['type'])
              : null,
          colours: item['colour'] != null
              ? (item['colour'] as List)
                  .map((colour) =>
                      ClothingColour.fromDatabaseRepresentation(colour))
                  .toList()
              : [],
          userId: item['userId'],
          user: item['user']?['name'],
          distance: item['distance'].toString().toDouble(),
          images:
              await decodeImageBase64((item['images'] as List).cast<String>()),
        );
      } catch (e) {
        // Log the error and return null
        if (kDebugMode) {
          print('Error processing item: $e');
        }
        return null;
      }
    }).toList(),
  ).then((results) =>
      results.where((item) => item != null).cast<ClothingInfo>().toList());
}

/// An enum for the type of clothing item.
enum ClothingType implements DatabaseRepresentationMapper<ClothingType> {
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
  String toString() {
    final String original = super.toString().split('.').last;
    final RegExp regex = RegExp(r'([a-z])([A-Z])');
    final String withSpaces = original.replaceAllMapped(regex, (match) {
      return '${match.group(1)} ${match.group(2)}';
    });
    return withSpaces[0].toUpperCase() + withSpaces.substring(1);
  }

  @override
  String getDatabaseRepresentation() {
    return super.toString().split('.').last;
  }

  static ClothingType fromDatabaseRepresentation(String value) {
    return ClothingType.values.firstWhere(
        (e) => e.getDatabaseRepresentation() == value,
        orElse: () =>
            throw ArgumentError('Invalid clothing type value: $value'));
  }
}

/// An enum for the style of code.
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

/// An enum for the clothing condition.
enum ClothingCondition with DatabaseRepresentationMapper<ClothingCondition> {
  newWithTags,
  newNoTags,
  likeNew,
  worn,
  wellWorn;

  @override
  String toString() {
    final String original = super.toString().split('.').last;
    final RegExp regex = RegExp(r'([a-z])([A-Z])');
    final String withSpaces = original.replaceAllMapped(regex, (match) {
      return '${match.group(1)} ${match.group(2)}';
    });
    return withSpaces[0].toUpperCase() + withSpaces.substring(1);
  }

  @override
  String getDatabaseRepresentation() {
    return super.toString().split('.').last;
  }

  static ClothingCondition fromDatabaseRepresentation(String value) {
    return ClothingCondition.values.firstWhere(
        (e) => e.getDatabaseRepresentation() == value,
        orElse: () => throw ArgumentError('Invalid condition value: $value'));
  }
}

/// An enum for the gender of the clothing item.
enum ClothingGender with DatabaseRepresentationMapper<ClothingGender> {
  male,
  female,
  unisex;

  @override
  String toString() {
    final String original = super.toString().split('.').last;
    final RegExp regex = RegExp(r'([a-z])([A-Z])');
    final String withSpaces = original.replaceAllMapped(regex, (match) {
      return '${match.group(1)} ${match.group(2)}';
    });
    return withSpaces[0].toUpperCase() + withSpaces.substring(1);
  }

  @override
  String getDatabaseRepresentation() {
    var str = super.toString().split('.');

    return str.last;
  }

  static ClothingGender fromDatabaseRepresentation(String value) {
    return ClothingGender.values.firstWhere(
        (e) => e.getDatabaseRepresentation() == value,
        orElse: () => throw ArgumentError('Invalid gender value: $value'));
  }
}

/// An enum for the categories of clothing items.
enum ClothingCategory { top, bottom, accessories }

/// An class for the size of an item that is abstract.
/// This allows multiple different size systems to be implemented.
sealed class ClothingSize with DatabaseRepresentationMapper<ClothingSize> {
  const ClothingSize();

  static ClothingSize fromDatabaseRepresentation(String value) {
    try {
      return LetteredSizing.fromDatabaseRepresentation(value);
    } catch (e) {
      return NumericalSizing.fromDatabaseRepresentation(value);
    }
  }
}

/// A class for lettered sizing which wraps the LetteredSize enum.
class LetteredSizing extends ClothingSize {
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

  static LetteredSizing fromDatabaseRepresentation(String value) {
    return LetteredSizing(LetteredSize.fromDatabaseRepresentation(value));
  }
}

/// An enum for lettered sizes of clothing items.
enum LetteredSize with DatabaseRepresentationMapper<LetteredSize> {
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

  static LetteredSize fromDatabaseRepresentation(String value) {
    return LetteredSize.values.firstWhere(
        (e) => e.getDatabaseRepresentation() == value,
        orElse: () => throw ArgumentError('Invalid sizing value: $value'));
  }

  String getSizeUpper() {
    return super.toString().split('.').last.toUpperCase();
  }
}

/// A class for numerical sizing which wraps an integer size.
class NumericalSizing extends ClothingSize {
  const NumericalSizing(this.size, this.system);

  final int size;
  final SizingSystem system;

  @override
  String toString() {
    return '$size (${system.toString().split('.').last.toUpperCase()})';
  }

  @override
  String getDatabaseRepresentation() {
    return '$size:${system.toString().split('.').last.toUpperCase()}';
  }

  static NumericalSizing fromDatabaseRepresentation(String value) {
    final parts = value.split(':');
    if (parts.length != 2) {
      throw ArgumentError('Invalid database representation: $value');
    }

    final size = int.parse(parts[0]);
    final system = SizingSystem.values.firstWhere(
      (e) => e.toString().split('.').last.toUpperCase() == parts[1],
      orElse: () =>
          throw ArgumentError('Invalid sizing system value: ${parts[1]}'),
    );

    return NumericalSizing(size, system);
  }
}

/// The system of numerical sizing being used.
enum SizingSystem { eu, uk, us }

/// An enum for the colour of a clothing item.
enum ClothingColour with DatabaseRepresentationMapper<ClothingColour> {
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
  String toString() {
    final String original = super.toString().split('.').last;
    final RegExp regex = RegExp(r'([a-z])([A-Z])');
    final String withSpaces = original.replaceAllMapped(regex, (match) {
      return '${match.group(1)} ${match.group(2)}';
    });
    return withSpaces[0].toUpperCase() + withSpaces.substring(1);
  }

  @override
  String getDatabaseRepresentation() {
    return super.toString().split('.').last;
  }

  static ClothingColour fromDatabaseRepresentation(String value) {
    return ClothingColour.values.firstWhere(
        (e) => e.getDatabaseRepresentation() == value,
        orElse: () => throw ArgumentError('Invalid colour value: $value'));
  }
}

/// The database representation mixin that provides the common function to get
/// database representation.
mixin DatabaseRepresentationMapper<T extends DatabaseRepresentationMapper<T>> {
  String getDatabaseRepresentation();
}
