import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0,),
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: const Color.fromRGBO(255, 87, 87, 1),
      ),
      body: Column(
        children: [
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
            child: ListView(
              children: List.generate(
                10,
                (index) => ListTile(
                  title: Text('Item $index'),
                  leading: const Icon(Icons.atm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
