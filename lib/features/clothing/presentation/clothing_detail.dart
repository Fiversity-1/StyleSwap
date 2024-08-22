import 'package:clothing_swap/features/clothing/presentation/clothing_item.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ClothingDetail extends StatelessWidget {
  const ClothingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    ClothingItemDetail item = ClothingItemDetail(
        bio:
            'This is an awesome black shirt that I really like a lot a lot a lot a lot a lot.',
        type: 'Shirt',
        size: 54,
        gender: 'Male',
        condition: 'Good',
        colours: [
          'Black',
          'Grey'
        ],
        images: [
          'lib/images/0.jpg',
          'lib/images/watermelon.png',
          'lib/images/watermelon2.jpg'
        ]);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 1,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: const Icon(Icons.swipe_down),
                    iconSize: 25,
                    onPressed: () {
                      Navigator.pushNamed(context, '/swipe');
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: (0.0)),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding:
                    kIsWeb ? const EdgeInsets.all(16) : const EdgeInsets.all(8),
                children: [
                  ListTile(
                    title: Text(
                      item.bio,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    leading: const Icon(Icons.info),
                  ),
                  ListTile(
                    title: Text(
                      "Type",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      item.type,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    leading: const Icon(Icons.category),
                  ),
                  ListTile(
                    title: Text(
                      "Size",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      item.size.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    leading: const Icon(Icons.numbers),
                  ),
                  ListTile(
                      selected: true,
                      title: Text(
                        "Gender",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle: Text(
                        item.gender,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      leading: const Icon(
                        Icons.person,
                      ),
                      trailing: const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )),
                  ListTile(
                      selected: true,
                      title: Text(
                        "Condition",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle: Text(
                        item.condition,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      leading: const Icon(
                        Icons.gpp_good_outlined,
                      ),
                      trailing: const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )),
                  ListTile(
                    title: Text(
                      "Colour",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      item.colours.join(", "),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    leading: const Icon(Icons.palette),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.025, width: width),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemBuilder: (_, index) => GridTile(
                child: GestureDetector(
                  onTap: () {},
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/gallery');
                    },
                    splashColor: Colors.white,
                    child: Ink.image(
                        fit: BoxFit.cover,
                        image: AssetImage(item.images[index])),
                  ),
                ),
              ),
              itemCount: item.images.length,
            ),
          ]),
        ),
      ),
    );
  }
}
