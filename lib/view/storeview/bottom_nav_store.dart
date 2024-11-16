import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/theme.dart';
import 'profile_Store.dart';
import 'request_view.dart';
import 'store_products.dart';

class BottomNavStore extends StatefulWidget {
  const BottomNavStore({super.key});

  @override
  State<BottomNavStore> createState() => _BottomNavStoreState();
}

class _BottomNavStoreState extends State<BottomNavStore> {
  int _bottomNavIndex = 0;

  List<Widget> _widgetOptions() {
    return [
      const StoreProducts(),
      const RequestView(),
      const ProfileStore(),
    ];
  }

  List<IconData> iconList = [
    CupertinoIcons.square_stack_3d_up_fill,
    Icons.task,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
          splashColor: ThemeColor.primary,
          activeColor: ThemeColor.primary,
          inactiveColor: Colors.black.withOpacity(.5),
          icons: iconList,
          gapWidth: 10,
          notchMargin: 33,
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
