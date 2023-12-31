import 'package:get/get_navigation/src/routes/get_route.dart';

import '../screens/auth_screens/login_screen.dart';
import '../screens/exercises_screen.dart';
import '../screens/my_bottom_nav_screen.dart';
import '../screens/onborading_screens/onboarding_screen.dart';
import '../screens/onborading_screens/splash_screen.dart';

class RoutesClass {
  static String splashScreen = "/";
  static String onboardingScreen = "/onboardingScreen";
  static String loginScreen = "/loginScreen";
  static String myBottomNavScreen = "/myBottomNavScreen";
  static String exercisesScreen = "/exercisesScreen";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardingScreen, page: () => const OnboardingScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: myBottomNavScreen, page: () => const MyBottomNavScreen()),
    GetPage(
        name: exercisesScreen,
        page: () => const ExercisesScreen(
              gifUrl: "",
              instructions: [],
              name: "",
              secondaryMuscles: [],
            )),
  ];
}
