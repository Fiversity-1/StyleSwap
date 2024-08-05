import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';

class ClothingDetail extends StatelessWidget {
  const ClothingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 1,
      ),
      body: Column(children: [
        SizedBox(height: height * 0.025, width: width),
        Text(
          'Description',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            height: 75,
            width: width,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              'This is a awesome shirt awesome shirt awesome shirt an awesome shirt an awesome shirt',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: height * 0.025, width: width),
        Text(
          'Category Breakdown!',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(top: (20.0)),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            children: const [
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
                  tileColor: Colors.blue,
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
                  tileColor: Colors.blue,
                  title: Text("Condition"),
                  textColor: Colors.white,
                  subtitle: Text("Good"),
                  leading: Icon(Icons.gpp_good_outlined, color: Colors.white),
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
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Back'),
        ),
      ]),
    );
  }
}
