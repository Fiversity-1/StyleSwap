// profile.dart

import 'package:clothing_swap/features/profile/presentation/profile_class.dart';

import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PublicProfile extends StatelessWidget {
  const PublicProfile({super.key});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 5),
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                          radius: 75,
                          backgroundImage: publicProfileExample.profilePicture),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
                width: 375,
                child: Text(
                  publicProfileExample.name,
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 75,
                        width: 300,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Theme.of(context).highlightColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          personalProfileExample.bio,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                    ],
                  )),
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
                    child: Image(
                        image: publicProfileExample.listings![index],
                        fit: BoxFit.cover),
                  ),
                ),

                //End modified code
                itemCount: publicProfileExample.listings!.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
