import 'package:clothing_swap/features/clothing/domain/clothing_info.dart';
import 'package:clothing_swap/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:string_extensions/string_extensions.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    int count = 0;
    List<List<Widget>> type = [[], [], [], []];
    List categories = [ClothingType.values, ClothingColour.values];

    type[count].add(
      Chip(
        label: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/clothes_preferences',
                arguments: 'Type');
          },
        ),
        backgroundColor: Theme.of(context).hoverColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Rounded edges
            side: BorderSide(color: Theme.of(context).hoverColor, width: 3)),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 0,
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      body: Row(
        children: [
          Visibility(
            visible: kIsWeb,
            child: Expanded(
                flex: 1,
                child: Container(
                  color: Theme.of(context).canvasColor,
                )),
          ),
          Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.05,
                      child: Image.asset('lib/images/backdrop.jpg',
                          fit: BoxFit.fitWidth),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: height * 0.025,
                        width: width,
                      ),
                      Text('Preferences',
                          style: kIsWeb
                              ? Theme.of(context).textTheme.headlineLarge
                              : Theme.of(context).textTheme.headlineMedium),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: (15.0), bottom: 15),
                        child: Row(
                          children: [
                            Text("Type",
                                style: kIsWeb
                                    ? Theme.of(context).textTheme.headlineSmall
                                    : Theme.of(context).textTheme.headlineSmall)
                          ],
                        ),
                      ),
                      Wrap(spacing: 10, runSpacing: 10, children: type[0]),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: (15.0), bottom: 15),
                        child: Row(
                          children: [
                            Text("Colour",
                                style: kIsWeb
                                    ? Theme.of(context).textTheme.headlineSmall
                                    : Theme.of(context).textTheme.headlineSmall)
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          Visibility(
            visible: kIsWeb,
            child: Expanded(
                flex: 1,
                child: Container(
                  color: Theme.of(context).canvasColor,
                )),
          ),
        ],
      ),
    );
  }
}
