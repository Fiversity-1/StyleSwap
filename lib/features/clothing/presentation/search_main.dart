import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _submitCreds = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 0,
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      body: Center(
          child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.10,
              child: Image.asset('lib/images/1.jpg', fit: BoxFit.cover),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: height * 0.2,
                width: width,
              ),
              Text('What are you looking for?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge),
              Padding(
                padding: const EdgeInsets.only(top: (20.0), bottom: (8.5)),
                child: SizedBox(
                  height: height * 0.0625,
                  width: width * 0.75,
                  child: TextField(
                    controller: _submitCreds,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      hintText: 'E.g. Gucci Baggy Blue Shirt',
                      filled: true,
                      suffix: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _submitCreds.clear();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: (15.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: const Text(
                          'Advanced Search',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/advanced_search');
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/swipe');
                        },
                        child: const Text(
                          'Search',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ],
      )),
    );
  }
}
