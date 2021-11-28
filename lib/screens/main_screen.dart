import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indian_zaika/constants/constants.dart';
import 'package:indian_zaika/screens/favourite_screen.dart';
import 'package:indian_zaika/screens/home_screen.dart';
import 'package:indian_zaika/screens/my_orders.dart';
import 'package:indian_zaika/screens/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main-screen';
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildScreens() {
      return [
        HomeScreen(),
        FavouriteScreen(),
        MyOrders(),
        ProfileScreen(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.cottage),
          title: ("Home"),
          activeColorPrimary: kAccentColor,
          inactiveColorPrimary: kNavbarInactive,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.favorite),
          title: ("Favorites"),
          activeColorPrimary: kAccentColor,
          inactiveColorPrimary: kNavbarInactive,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.shopping_bag),
          title: ("My Orders"),
          activeColorPrimary: kAccentColor,
          inactiveColorPrimary: kNavbarInactive,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.face),
          title: ("Profile"),
          activeColorPrimary: kAccentColor,
          inactiveColorPrimary: kNavbarInactive,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: kNavbarBackColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(15.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style12, // Choose the nav bar style with this property.
    );
  }
}
