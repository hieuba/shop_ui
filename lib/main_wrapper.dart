import 'package:animate_do/animate_do.dart';
import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shop_ui/screens/cart/cart.dart';
import 'package:shop_ui/screens/home/home.dart';
import 'package:shop_ui/screens/search/search.dart';
import 'package:shop_ui/utils/constants.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  bool isSearchActive = false;

  final List<Widget> _widgetOptions = [
    const Home(),
    const Center(
      child: Text('explore'),
    ),
    const Center(
      child: Text('setting'),
    ),
    const Center(
      child: Text('person'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppbar(),
      body: isSearchActive ? const Search() : _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomBarBubble(
        color: primaryColor,
        selectedIndex: _selectedIndex,
        onSelect: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: [
          BottomBarItem(iconData: Icons.home),
          BottomBarItem(iconData: Icons.explore),
          BottomBarItem(iconData: Icons.settings),
          BottomBarItem(iconData: Icons.person),
        ],
      ),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: isSearchActive
          ? FadeInUp(
              child: Text(
              'Search',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ))
          : FadeInUp(
              child: Text(
              'Home',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
              ),
            )),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSearchActive = !isSearchActive;
            });
          },
          icon: isSearchActive
              ? const Icon(
                  LineIcons.searchMinus,
                  color: Colors.black,
                )
              : const Icon(
                  LineIcons.search,
                  color: Colors.black,
                ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Cart(),
            ));
          },
          icon: const Icon(
            LineIcons.shoppingBag,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
