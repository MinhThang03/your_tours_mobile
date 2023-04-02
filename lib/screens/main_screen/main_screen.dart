import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/screens/history_booking_page/history_booking_screen.dart';

import '../favourite/favourite_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  final int selectedInit;

  const MainScreen({Key? key, required this.selectedInit}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex = widget.selectedInit;
  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    FavouriteScreen(),
    HistoryBookingScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);
    return Scaffold(
      body: Container(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 20.0,
                offset: const Offset(1.0, 1.0)),
          ],
        ),
        child: ClipRRect(
          child: BottomNavigationBar(
              elevation: 20.0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label: 'Home',
                  activeIcon: SvgPicture.asset(
                    "assets/icons/Shop Icon.svg",
                    color: kPrimaryColor,
                  ),
                  icon: SvgPicture.asset(
                    "assets/icons/Shop Icon.svg",
                    color: inActiveIconColor,
                  ),
                ),
                BottomNavigationBarItem(
                    label: 'Favorite',
                    activeIcon: SvgPicture.asset(
                      "assets/icons/Heart Icon.svg",
                      color: kPrimaryColor,
                    ),
                    icon: SvgPicture.asset(
                      "assets/icons/Heart Icon.svg",
                      color: inActiveIconColor,
                    )),
                BottomNavigationBarItem(
                    label: 'Chat Box',
                    activeIcon: SvgPicture.asset(
                      "assets/icons/Chat bubble Icon.svg",
                      color: kPrimaryColor,
                    ),
                    icon: SvgPicture.asset(
                      "assets/icons/Chat bubble Icon.svg",
                      color: inActiveIconColor,
                    )),
                BottomNavigationBarItem(
                    label: 'Profile',
                    activeIcon: SvgPicture.asset(
                      "assets/icons/User Icon.svg",
                      color: kPrimaryColor,
                    ),
                    icon: SvgPicture.asset(
                      "assets/icons/User Icon.svg",
                      color: inActiveIconColor,
                    )),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped),
        ),
      ),
    );
  }
}
