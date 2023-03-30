import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:sv_craft/Features/grocery/view/grocery_product.dart';
import 'package:sv_craft/constant/color.dart';


class GroceryNav extends StatefulWidget {
  const GroceryNav({Key? key}) : super(key: key);

  @override
  State<GroceryNav> createState() => _GroceryNavState();
}

class _GroceryNavState extends State<GroceryNav> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    // const HomeScreen(),
    // const HomeScreen(),
    GroceryProduct(),
    // const HomeScreen(),
    // ProfileScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.primaryColor,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Appcolor.iconColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Appcolor.primaryColor,
        // fixedColor: Colors.red,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: const BoxDecoration(
                border: Border(
                    // top: BorderSide(
                    //   color: _page == 0
                    //       ? Appcolor.selectedNavBarColor
                    //       : Appcolor.backgroundColor,
                    //   //width: bottomBarBorderWidth,
                    // ),
                    ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(),
              ),
              child: Badge(
                elevation: 0,
                badgeContent: Text(
                  3.toString(),
                  style: TextStyle(
                    color: _page == 1 ? Appcolor.iconColor : Colors.grey,
                    fontSize: 15,
                  ),
                ),
                badgeColor: Appcolor.primaryColor,
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
            label: 'Cart',
          ),

          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(),
              ),
              child: const Icon(
                Icons.person,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
