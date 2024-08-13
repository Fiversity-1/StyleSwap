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
        brand: 'Anko',
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
            SizedBox(height: height * 0.015, width: width),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    iconSize: 25,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, '/swipe');
                    }),
                Text(
                  'Info',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: (4)),
                ),
                const Text(
                  ' ',
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: (0.0)),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                children: [
                  ListTile(
                    tileColor: Colors.white,
                    title: Text(item.bio),
                    leading: const Icon(Icons.info),
                  ),
                  ListTile(
                    tileColor: Colors.white,
                    title: const Text("Type"),
                    subtitle: Text(item.type),
                    leading: const Icon(Icons.category),
                  ),
                  ListTile(
                    tileColor: Colors.white,
                    title: const Text("Size"),
                    subtitle: Text(item.size.toString()),
                    leading: const Icon(Icons.numbers),
                  ),
                  ListTile(
                      tileColor: Colors.green,
                      title: const Text("Gender"),
                      textColor: Colors.white,
                      subtitle: Text(item.gender),
                      leading: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      trailing: const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )),
                  ListTile(
                    tileColor: Colors.white,
                    title: const Text("Brand"),
                    subtitle: Text(item.brand),
                    leading: const Icon(Icons.type_specimen),
                  ),
                  ListTile(
                      tileColor: Colors.green,
                      title: const Text("Condition"),
                      textColor: Colors.white,
                      subtitle: Text(item.condition),
                      leading: const Icon(Icons.gpp_good_outlined,
                          color: Colors.white),
                      trailing: const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )),
                  ListTile(
                    tileColor: Colors.white,
                    title: const Text("Colour"),
                    subtitle: Text(item.colours.join(", ")),
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
            Padding(
              padding: const EdgeInsets.only(top: (10.0), bottom: (10)),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/swipe');
                },
                child: const Text('Back'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
