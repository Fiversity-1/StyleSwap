//Generative Code
class ClothingItem {
  final String name;
  final String location;
  final List<String> images;
  int currentIndex;

  ClothingItem(
      {required this.name,
      required this.location,
      required this.images,
      this.currentIndex = 0});
}

class ClothingItemDetail {
  final String bio;
  final String type;
  final int size;
  final String gender;

  final String condition;
  final List<String> colours;
  final List<String> images;
  ClothingItemDetail({
    required this.bio,
    required this.type,
    required this.size,
    required this.gender,
    required this.condition,
    required this.colours,
    required this.images,
  });
}
