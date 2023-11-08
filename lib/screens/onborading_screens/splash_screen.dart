import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/image_paths.dart';
import '../../utils/strings.dart';
import '../auth_screens/login_screen.dart';
import '../my_bottom_nav_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Widget _initialScreen;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      _determineInitialScreen();
    });
  }

  void _determineInitialScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasCompletedOnboarding =
        prefs.getBool('has_completed_onboarding') ?? false;

    if (!hasCompletedOnboarding) {
      //New Onboarding
      setState(() {
        _initialScreen = const OnboardingScreen();
      });
      Get.offAll(_initialScreen);
    } else {
      setState(() {
        final auth = FirebaseAuth.instance;
        final user = auth.currentUser;
        if (user != null) {
          Get.offAll(const MyBottomNavScreen());
        } else {
          Get.offAll(const LoginScreen());
        }
      });
    }
  }

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
            image: AssetImage(splash),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
