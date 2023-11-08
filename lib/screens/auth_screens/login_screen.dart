import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_motion/screens/auth_screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../services/auth_services.dart';
import '../../utils/app_colors.dart';
import '../../utils/auth_toast.dart';
import '../../utils/image_paths.dart';
import '../../utils/my_button.dart';
import '../../utils/my_form_field.dart';
import '../../utils/strings.dart';
import '../my_bottom_nav_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(loginBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyFormField(
                      controller: emailController,
                      hintText: yourEmail,
                      validator: (value) {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);
                        if (value.isEmpty) {
                          return "Enter Email";
                        } else if (!emailValid) {
                          return "Enter valid Email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    MyFormField(
                      controller: passwordController,
                      hintText: yourPassword,
                      suffixIcon: Icons.visibility_outlined,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        } else if (passwordController.text.length < 6) {
                          return "Password length should be more than 6 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      or,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorWhite,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    InkWell(
                      onTap: () async {
                        final authService = AuthService();
                        final user = await authService.signInWithGoogle();
                        if (user != null) {
                          Get.offAll(const MyBottomNavScreen());
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50.h,
                        padding: REdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          color: colorWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              google,
                              height: 24.h,
                              width: 24.w,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              continueWithGoogle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colorBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: REdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: [
                    MyButton(
                      loading: loading,
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });
                        _auth
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text.toString())
                            .then((value) {
                          AuthToast()
                              .toastMessage(value.user!.email.toString());
                          Get.offAll(const MyBottomNavScreen());
                          setState(() {
                            loading = false;
                          });
                        }).onError((error, stackTrace) {
                          debugPrint(error.toString());
                          AuthToast().toastMessage(error.toString());
                          setState(() {
                            loading = false;
                          });
                        });
                      },
                      text: login,
                    ),
                    Gap(2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: colorWhite,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(const SignupScreen());
                          },
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(5),
                              minimumSize: const Size(50, 20),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerLeft),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: colorPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
