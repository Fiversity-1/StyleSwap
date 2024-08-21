// profile.dart
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Profile extends StatelessWidget {
  const Profile({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 3,
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 5),
                child: SizedBox(
                  height: 150,
                  width: 180,
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage('lib/images/profilepicture.jpg'),
                  ),
                ),
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 50,
                    width: 375,
                    child: Text(
                      'Steve',
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 65,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(7)),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 15),
                child: Container(
                  height: 75,
                  width: 300,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Theme.of(context).highlightColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'I love food and sustainability! Keen to trade some clothes!',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: kIsWeb ? 3 : 2,
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
                      splashColor: Theme.of(context).primaryColorLight,
                      child: Ink.image(
                          fit: BoxFit.cover,
                          image: const AssetImage('lib/images/backdrop.jpg')),
                    ),
                  ),
                ),
                itemCount: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
