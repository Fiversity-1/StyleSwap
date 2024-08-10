import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ClothingDetail extends StatelessWidget {
  const ClothingDetail({super.key});

  @override
  Widget build(BuildContext context) {
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
                Text(
                  ' ',
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: (0.0)),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                children: const [
                  ListTile(
                    tileColor: Colors.white,
                    title: Text(
                        'This is a awesome shirt awesome shirt awesome shirt an awesome shirtan awesome shirtan awesome shirtan awesome shirt an awesome shirt'),
                    leading: Icon(Icons.info),
                  ),
                  ListTile(
                    tileColor: Colors.white,
                    title: Text("Type"),
                    subtitle: Text("Pants"),
                    leading: Icon(Icons.category),
                  ),
                  ListTile(
                    tileColor: Colors.white,
                    title: Text("Size"),
                    subtitle: Text("32"),
                    leading: Icon(Icons.numbers),
                  ),
                  ListTile(
                      tileColor: Colors.green,
                      title: Text("Gender"),
                      textColor: Colors.white,
                      subtitle: Text("Male"),
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      trailing: Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )),
                  ListTile(
                    tileColor: Colors.white,
                    title: Text("Brand"),
                    subtitle: Text("Gucci"),
                    leading: Icon(Icons.type_specimen),
                  ),
                  ListTile(
                      tileColor: Colors.green,
                      title: Text("Condition"),
                      textColor: Colors.white,
                      subtitle: Text("Good"),
                      leading:
                          Icon(Icons.gpp_good_outlined, color: Colors.white),
                      trailing: Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )),
                  ListTile(
                    tileColor: Colors.white,
                    title: Text("Colour"),
                    subtitle: Text("Green"),
                    leading: Icon(Icons.palette),
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
                        image: const AssetImage('lib/images/1.jpg')),
                  ),
                ),
              ),
              itemCount: 4,
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
