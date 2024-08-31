import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/swipe');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/add_clothing_item');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/message');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/personal_profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Theme.of(context).scaffoldBackgroundColor,
        ), // sets the inactive color of the `BottomNavigationBar`
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add), label: 'Add Clothing'),
            BottomNavigationBarItem(
                icon: Icon(Icons.messenger_rounded), label: 'Message'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: currentIndex,
          onTap: (index) => _onItemTapped(context, index),
        ));
  }
}
