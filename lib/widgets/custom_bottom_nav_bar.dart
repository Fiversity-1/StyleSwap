import 'package:clothing_swap/features/community/domain/event_class.dart';
import 'package:flutter/material.dart';

//Custom Bottom Navigation bar
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
  });
  //handles routes based on which icon pressed
  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/swipe');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/add_clothing_item');
        break;
      case 2:
        Navigator.pushNamed(context, '/events', arguments: communityEvents);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/personal_profile');
        break;
    }
  }

  @override
  //GPT for Icon size; particularly "selectedIconTheme","unselectedIconTheme"
  //GPT use for setting selected/unseletected FontSize to 0 to prevent shifting
  //GPT used for setting background and inactive colour of the navigation bar
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Theme.of(context).appBarTheme.backgroundColor,
        ), // sets the inactive color of the `BottomNavigationBar`
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0, // Set to 0 to prevent font-related shifts
          unselectedFontSize: 0, // Set to 0 to prevent font-related shifts
          type: BottomNavigationBarType.fixed,
          elevation: 0,

          selectedIconTheme:
              const IconThemeData(size: 26), // Set size for selected icons
          unselectedIconTheme:
              const IconThemeData(size: 26), // Set size for unselected icons
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          ],
          currentIndex: currentIndex,
          onTap: (index) => _onItemTapped(context, index),
        ));
  }
}
