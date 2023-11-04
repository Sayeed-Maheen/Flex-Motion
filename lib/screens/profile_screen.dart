import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../utils/app_colors.dart';
import '../utils/image_paths.dart';
import 'my_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  final List<String> _screenName = [
    'My Profile',
    'My Goals',
    'BMI',
    'BMR',
    'Log out',
  ];

  final List<String> _icons = [
    myProfile,
    myGoals,
    bmi,
    bmr,
    logout,
  ];
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorWhite,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          elevation: 4,
          flexibleSpace: Container(
            color: colorPrimary, // Set a fixed color here
          ),
          title: Text(
            "Profile",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: colorWhite,
            ),
          ),
        ),
        body: Column(children: [
          Gap(16.h),
          Center(
            child: ClipOval(
              child: Image.asset(
                profileImage,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
          ),
          Gap(12.h),
          Text(
            "Sayeed Hassan",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: colorBlack,
            ),
          ),
          Text(
            "sayeedhassan1124@gmail.com",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: colorGray,
            ),
          ),
          Gap(24.h),
          ...List.generate(_screenName.length, (index) {
            return InkWell(
                splashFactory: NoSplash.splashFactory,
                highlightColor: Colors.transparent, // and here
                onTap: () {
                  // Use the index to determine which screen to open.
                  switch (index) {
                    case 0:
                      Get.to(const MyProfileScreen());
                      break;
                    case 1:
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => screenRoutes[1](),
                      // ));
                      break;
                    case 2:
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => screenRoutes[2](),
                      // ));
                      break;
                    case 3:
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => screenRoutes[3](),
                      // ));
                      break;
                    default:
                      // Handle any other cases here
                      break;
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: REdgeInsets.all(16),
                  margin: REdgeInsets.only(left: 16, right: 16, bottom: 12),
                  decoration: BoxDecoration(
                    color: colorLighterGray,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            _icons[index],
                            height: 16.w,
                            width: 16.w,
                            color: index == _screenName.length - 1
                                ? colorDanger
                                : colorBlack,
                          ),
                          Gap(12.w),
                          Text(
                            _screenName[index],
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: index == _screenName.length - 1
                                  ? colorDanger
                                  : colorBlack,
                            ),
                          ),
                        ],
                      ),
                      if (index != _screenName.length - 1)
                        SvgPicture.asset(
                          rightArrow,
                          height: 16.w,
                          width: 16.w,
                        ),
                    ],
                  ),
                ));
          }),
        ]));
  }
}
