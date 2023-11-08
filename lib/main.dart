import 'package:firebase_core/firebase_core.dart';
import 'package:flex_motion/routes/routes.dart';
import 'package:flex_motion/utils/app_colors.dart';
import 'package:flex_motion/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: appName,
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: "Outfit",
              colorScheme: ColorScheme.fromSeed(seedColor: colorPrimary)
                  .copyWith(background: Colors.transparent),
            ),
            initialRoute: "splashScreen",
            getPages: RoutesClass.routes,
          );
        });
  }
}
