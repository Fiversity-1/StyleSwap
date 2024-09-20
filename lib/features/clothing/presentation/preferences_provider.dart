import 'package:flutter/material.dart';

//Track user preferences for each search category
//GPT used to implement this page based on speicifications given.
class PreferencesNotifier extends ChangeNotifier {
  final List<String> _typePreferences = [];
  final List<String> _sizePreferences = [];
  final List<String> _colorPreferences = [];
  final List<String> _conditionPreferences = [];
  final List<String> _genderPreferences = [];
  double locationDistance = 50;

  double getDistance() {
    return locationDistance;
  }

  void setDistance(double newValue) {
    locationDistance = newValue;
  }

  List<String> getPreferences(String category) {
    switch (category) {
      case 'Type':
        return _typePreferences;
      case 'Size':
        return _sizePreferences;
      case 'Colour':
        return _colorPreferences;
      case 'Condition':
        return _conditionPreferences;
      case 'Gender':
        return _genderPreferences;
      default:
        throw ArgumentError('Invalid category: $category');
    }
  }

  void addPreference(String category, String preference) {
    switch (category) {
      case 'Type':
        _typePreferences.add(preference);
        break;
      case 'Size':
        _sizePreferences.add(preference);
        break;
      case 'Colour':
        _colorPreferences.add(preference);
        break;
      case 'Condition':
        _conditionPreferences.add(preference);
        break;
      case 'Gender':
        _genderPreferences.add(preference);
        break;
      default:
        throw ArgumentError('Invalid category: $category');
    }
    notifyListeners();
  }

  void removePreference(String category, String preference) {
    switch (category) {
      case 'Type':
        _typePreferences.remove(preference);
        break;
      case 'Size':
        _sizePreferences.remove(preference);
        break;
      case 'Colour':
        _colorPreferences.remove(preference);
        break;
      case 'Condition':
        _conditionPreferences.remove(preference);
        break;
      case 'Gender':
        _genderPreferences.remove(preference);
        break;
      default:
        throw ArgumentError('Invalid category: $category');
    }
    notifyListeners();
  }
}
