import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_colors.dart';
import '../../utils/image_paths.dart';
import '../../utils/my_button.dart';
import '../../utils/strings.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(onboardingBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 90.h),
                SvgPicture.asset(
                  logo,
                  height: 40.h,
                  width: 200.w,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  startWorkout,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorWhite,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.46,
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    startWorkoutSubtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorWhite,
                      fontSize: 16.sp,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.15,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: MyButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('has_completed_onboarding', true);
                  Get.offAllNamed("loginScreen");
                },
                text: getStarted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
