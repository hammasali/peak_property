import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/drawer/custom_drawer.dart';
import 'package:peak_property/presentation/alerts/alerts.dart';
import 'package:peak_property/presentation/chat/chats_page.dart';

import 'bookmark/bookmark.dart';
import 'home/fixed/fixed.dart';
import 'home/home.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({Key? key}) : super(key: key);

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation>
    with SingleTickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0;

  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;

  final iconList = <IconData>[
    FontAwesomeIcons.home,
    Icons.bookmark,
    FontAwesomeIcons.solidBell,
    Icons.chat_bubble_rounded,
  ];

  static  final List<Widget> _children = <Widget>[
    const Home(),
    // Bookmark(),
    const Bookmark(),
    const Notifications(),
    const ChatsPage(),
  ];

  final navList = <String>[
    MyApp.home,
    MyApp.bookmark,
    MyApp.alerts,
    MyApp.chat,
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      const Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        title: Text(
          navList[_bottomNavIndex],
          style: const TextStyle(color: Colors.black),
        ),
        leading: const Icon(
          FontAwesomeIcons.search,
          size: MyApp.kDefaultIconSize - 5,
          color: Colors.black,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: MyApp.kDefaultBackgroundColorWhite,
        centerTitle: true,
        elevation: 0.5,
      ),
      body: IndexedStack(children: _children, index: _bottomNavIndex),
      floatingActionButton: ScaleTransition(
        scale: animation,
        child: FloatingActionButton(
          elevation: 8,
          backgroundColor: MyApp.kDefaultButtonColorBlack.withOpacity(0.9),
          child: const Icon(
            Icons.add,
            color: MyApp.kDefaultBackgroundColorWhite,
          ),
          onPressed: () {
            _animationController.reset();
            _animationController.forward();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        backgroundColor: MyApp.kDefaultBackgroundColorWhite,
        activeIndex: _bottomNavIndex,
        splashColor: MyApp.kDefaultButtonColorBlack,
        notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.smoothEdge,
        gapLocation: GapLocation.center,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? MyApp.kDefaultTextColorBlack : Colors.grey;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AutoSizeText(
                  navList[index],
                  maxLines: 1,
                  style: TextStyle(color: color),
                  group: autoSizeGroup,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

// class NavigationScreen extends StatefulWidget {
//   final IconData iconData;
//
//   const NavigationScreen({Key? key, required this.iconData}) : super(key: key);
//
//   @override
//   _NavigationScreenState createState() => _NavigationScreenState();
// }
//
// class _NavigationScreenState extends State<NavigationScreen>
//     with TickerProviderStateMixin {
//
//   late AnimationController _controller;
//   late Animation<double> animation;
//
//   @override
//   void didUpdateWidget(NavigationScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.iconData != widget.iconData) {
//       _startAnimation();
//     }
//   }
//
//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//     animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
//     );
//     _controller.forward();
//     super.initState();
//   }
//
//   _startAnimation() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//     animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
//     );
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: CircularRevealAnimation(
//           animation: animation,
//           centerOffset: const Offset(80, 80),
//           maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
//           child: Icon(
//             widget.iconData,
//             color: HexColor('#FFA400'),
//             size: 160,
//           ),
//         ),
//       ),
//     );
//   }
// }

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
