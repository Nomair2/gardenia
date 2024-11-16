import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/theme.dart';
import 'package:gardenia/view/userview/InYourHandScreen.dart';
import 'package:gardenia/view/userview/homeUser.dart';
import 'package:gardenia/view/userview/myRequest.dart';
import 'package:gardenia/view/userview/profile_user_screen.dart';

class BottomNavBarUser extends StatefulWidget {
  const BottomNavBarUser({super.key});

  @override
  State<BottomNavBarUser> createState() => _BottomNavBarUserState();
}

class _BottomNavBarUserState extends State<BottomNavBarUser> {
  int _bottomNavIndex = 0;

  List<Widget> _widgetOptions() {
    return [
      const Homeuser(),
      const MyRequest(),
      const Inyourhandscreen(),
      const ProfileUserScreen(),
    ];
  }

  List<IconData> iconList = [
    Icons.home,
    Icons.request_page,
    Icons.back_hand,
    Icons.person,
  ];

  List<String> titleList = [
    'Home',
    "My Request",
    'In Your Hand',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: ThemeColor.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              titleList[_bottomNavIndex],
              style: TextStyle(
                color: ThemeColor.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
          ],
        ),
        backgroundColor: ThemeColor.background,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
          splashColor: ThemeColor.primary,
          activeColor: ThemeColor.primary,
          inactiveColor: Colors.black.withOpacity(.5),
          icons: iconList,
          notchMargin: 33,
          gapWidth: 10,
          iconSize: 35,
          activeIndex: _bottomNavIndex,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: (index) {
            setState(() {
              _bottomNavIndex = index;
            });
          }),
    );
  }
}
