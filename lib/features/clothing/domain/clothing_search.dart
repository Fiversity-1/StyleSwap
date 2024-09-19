
import 'dart:ffi';

import 'clothing_info.dart';
import 'clothing_type.dart';

class ClothingSearch {
  final List<ClothingType>? types;
  final List<ClothingSize>? sizes;
  final List<ClothingColour>? colours;
  final List<ClothingCondition>? conditions;
  final List<ClothingGender>? genders;
  final int distance;

  ClothingSearch(this.distance, {this.types, this.sizes, this.colours,
    this.conditions, this.genders});

  Map<String, dynamic> getData() {
    Map<String, dynamic> data = {};

    addData(data, "type", types);
    addData(data, "size", sizes);
    addData(data, "colour", colours);
    addData(data, "condition", conditions);
    addData(data, "gender", genders);

    data["distance"] = distance.toString();

    return data;
  }

  void addData(Map<String, dynamic> data, String key,
      List<DatabaseRepresentationMapper>? props) {
    if (props != null) {
      data[key] = props.map((type) => type.getDatabaseRepresentation());
    }
  }
}