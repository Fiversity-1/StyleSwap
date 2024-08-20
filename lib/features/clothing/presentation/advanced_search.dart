import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Category {
  final String category;
  final IconData logo;
  final List options;
  Category({required this.category, required this.logo, required this.options});
}

List<Category> categories = [
  Category(category: 'Type', logo: Icons.category, options: ['Shirt', 'Pants']),
  Category(category: 'Size', logo: Icons.numbers, options: [1, 2, 3, 4, 5]),
  Category(category: 'Gender', logo: Icons.person, options: ['Male', 'Female']),
  Category(
      category: 'Condition',
      logo: Icons.gpp_good_outlined,
      options: ['Brand New', 'Barely Worn', 'Good', 'Bit how\'s it going...']),
  Category(
      category: 'Colour',
      logo: Icons.palette,
      options: ['Yellow', 'Green', 'Red', 'Blue']),
];

class AdvancedSearch extends StatefulWidget {
  const AdvancedSearch({super.key});

  @override
  State<AdvancedSearch> createState() => _AdvancedSearchState();
}

class _AdvancedSearchState extends State<AdvancedSearch> {
  //use this for indexing queries/views
  int _counter = 0;
  Set<int> selectedTiles = {};
  List colours = [];
  int _tileCounter = 0;

  void _changeCategory() {
    setState(() {
      _counter++;
      _tileCounter = 0;
      selectedTiles.clear();
    });
    if (_counter == categories.length) {
      Navigator.pushNamed(context, '/swipe');
      //send over relevant images to be shown
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 0,
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: (5), top: (10)),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      iconSize: 20,
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: (10)),
                    child: Text(
                      'Select ${categories[_counter].category}',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: (10)),
                  child: Visibility(
                      visible:
                          (_tileCounter == 0 || _counter == 0) ? false : true,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        iconSize: 25,
                        onPressed: () {
                          _changeCategory();
                        },
                      )))
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: categories[_counter].options.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      onTap: () {
                        _tileCounter++;
                        _counter != 0
                            ? setState(() {
                                if (selectedTiles.contains(index)) {
                                  selectedTiles.remove(index);
                                } else {
                                  selectedTiles.add(index);
                                }
                              })
                            : _changeCategory();
                        //backend send, retrieval
                      },
                      selected: selectedTiles.contains(index),
                      title: Text(
                        '${categories[_counter].options[index]}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      leading: Icon(categories[_counter].logo));
                }),
          ),
        ],
      ),
    );
  }
}
