import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/image_paths.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
            image: AssetImage(loginBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          // child: Padding(
          //   padding: REdgeInsets.all(12),
          //   child: Text(
          //     appVersion,
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 14.sp,
          //       fontFamily: 'Roboto',
          //       fontWeight: FontWeight.w400,
          //       letterSpacing: 0.15,
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
