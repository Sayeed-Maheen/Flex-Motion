import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uxpros/screens/profile_screen.dart';
import 'package:uxpros/screens/program_screen.dart';
import 'package:uxpros/screens/reports_screen.dart';
import 'package:uxpros/screens/timer_screen.dart';
import 'package:uxpros/utils/app_colors.dart';

import '../utils/image_paths.dart';
import '../utils/strings.dart';
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
    ProgramScreen(),
    const ReportsScreen(),
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
      key: _scaffoldKey,
      appBar: _selectedIndex == 0
          ? AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              elevation: 4,
              flexibleSpace: Container(
                color: colorPrimary, // Set a fixed color here
              ),
              title: Text(
                homeText,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: colorWhite,
                ),
              ),
              titleSpacing: -1,
              leading: _selectedIndex == 0
                  ? MaterialButton(
                      child: SvgPicture.asset(
                        drawer,
                        height: 24.h,
                        width: 24.w,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    )
                  : null,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    notification,
                    height: 22.h,
                    width: 22.w,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    search,
                    height: 22.h,
                    width: 22.w,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    home,
                    height: 22.h,
                    width: 22.w,
                  ),
                ),
              ],
            )
          : null,
      drawer: _selectedIndex == 0
          ? Drawer(
              child: Center(
                child: MaterialButton(
                  child: const Text("Press"),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const Hello1()),
                    // );
                  },
                ),
              ),
            )
          : null,
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
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              program,
              height: 24.h,
              width: 24.w,
              color: _selectedIndex == 2 ? colorPrimary : colorLightGray,
            ),
            label: 'Program',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              reports,
              height: 24.h,
              width: 24.w,
              color: _selectedIndex == 3 ? colorPrimary : colorLightGray,
            ),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              profile,
              height: 24.h,
              width: 24.w,
              color: _selectedIndex == 4 ? colorPrimary : colorLightGray,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
