import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../utils/auth_toast.dart';
import '../../utils/image_paths.dart';
import '../../utils/my_button.dart';
import '../../utils/my_form_field.dart';
import '../../utils/strings.dart';
import '../my_bottom_nav_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
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
                      controller: nameController,
                      hintText: yourName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
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
                        if (_formKey.currentState!.validate()) {
                          // Clear the email and password fields

                          setState(() {
                            loading = true;
                          });
                          _auth
                              .createUserWithEmailAndPassword(
                                  email: emailController.text.toString(),
                                  password: passwordController.text.toString())
                              .then((value) {
                            setState(() {
                              loading = false;
                            });
                          }).onError((error, stackTrace) {
                            AuthToast().toastMessage(error.toString());
                            setState(() {
                              loading = false;
                            });
                          });
                          Get.offAll(const MyBottomNavScreen());
                        }
                      },
                      text: register,
                    ),
                    Gap(2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: colorWhite,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offAll(const LoginScreen());
                          },
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(5),
                              minimumSize: const Size(50, 20),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerLeft),
                          child: Text(
                            "Login",
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
