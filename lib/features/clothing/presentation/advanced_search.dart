import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';

class Category {
  final String category;
  final IconData logo;
  final List options;
  Category({required this.category, required this.logo, required this.options});
}

List<Category> categories = [
  Category(category: 'Type', logo: Icons.category, options: [1, 2, 3]),
  Category(category: 'Size', logo: Icons.numbers, options: [1, 2, 3, 4, 5]),
  Category(category: 'Gender', logo: Icons.person, options: [1, 2, 3, 4, 5, 6]),
  Category(
      category: 'Brand',
      logo: Icons.type_specimen,
      options: [1, 2, 3, 4, 5, 6]),
  Category(
      category: 'Condition',
      logo: Icons.gpp_good_outlined,
      options: [1, 2, 3, 4, 5, 6]),
  Category(
      category: 'Colour', logo: Icons.palette, options: [1, 2, 3, 4, 5, 6]),
];

class AdvancedSearch extends StatefulWidget {
  const AdvancedSearch({super.key});

  @override
  State<AdvancedSearch> createState() => _AdvancedSearchState();
}

class _AdvancedSearchState extends State<AdvancedSearch> {
  //use this for indexing queries/views
  int _counter = 0;
  List colours = [];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    if (_counter == categories.length) {
      Navigator.pushNamed(context, '/swipe');
      //send over relevant images to be shown
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        _incrementCounter();
                        //backend send, retrieval
                      },
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
