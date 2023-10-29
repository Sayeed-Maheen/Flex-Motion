import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:uxpros/routes/routes.dart';
import 'package:uxpros/utils/app_colors.dart';
import 'package:uxpros/utils/strings.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
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