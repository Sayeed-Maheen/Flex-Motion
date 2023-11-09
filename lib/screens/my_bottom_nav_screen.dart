import 'package:flex_motion/screens/profile_screen.dart';
import 'package:flex_motion/screens/program_screen.dart';
import 'package:flex_motion/screens/timer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/app_colors.dart';
import '../utils/image_paths.dart';
import '../utils/strings.dart';
import 'health_tips_screen.dart';
import 'home_screen.dart';

class MyBottomNavScreen extends StatefulWidget {
  const MyBottomNavScreen({Key? key}) : super(key: key);

  @override
  _MyBottomNavScreenState createState() => _MyBottomNavScreenState();
}

class _MyBottomNavScreenState extends State<MyBottomNavScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(), // Replace with your actual home screen widget
    const TimerScreen(),
    const ProgramScreen(),
    const HealthTipsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: colorWhite,
        selectedItemColor: colorPrimary,
        selectedFontSize: 12.sp,
        unselectedFontSize: 12.sp,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              home,
              height: 24.h,
              width: 24.w,
              color: _selectedIndex == 0 ? colorPrimary : colorLightGray,
            ),
            label: homeText,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              timer,
              height: 24.h,
              width: 24.w,
              color: _selectedIndex == 1 ? colorPrimary : colorLightGray,
            ),
            label: timerText,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              program,
              height: 24.h,
              width: 24.w,
              color: _selectedIndex == 2 ? colorPrimary : colorLightGray,
            ),
            label: programText,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              tips,
              height: 24.h,
              width: 24.w,
              color: _selectedIndex == 3 ? colorPrimary : colorLightGray,
            ),
            label: tipsText,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              profile,
              height: 24.h,
              width: 24.w,
              color: _selectedIndex == 4 ? colorPrimary : colorLightGray,
            ),
            label: profileText,
          ),
        ],
      ),
    );
  }
}
