import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../utils/app_colors.dart';
import '../utils/image_paths.dart';
import '../utils/my_button.dart';

enum Gender { male, female }

class Logic {
  double calculateBMI(int heightFeet, int heightInches, int weight) {
    double heightInMeters = (heightFeet * 12 + heightInches) * 0.0254;
    return weight / (heightInMeters * heightInMeters);
  }
}

class BmrScreen extends StatefulWidget {
  const BmrScreen({super.key});

  @override
  _BmrScreenState createState() => _BmrScreenState();
}

class _BmrScreenState extends State<BmrScreen> {
  int weight = 70;
  int age = 25;
  int heightFeet = 5;
  int heightInches = 6;
  double sliderValue = 66.025;
  double bmr = 0.0;
  Gender selectedGender = Gender.male;

  void calculateBMR() {
    // Convert height to inches
    int totalHeightInches = (heightFeet * 12) + heightInches;

    // Calculate BMR using the Harris-Benedict equation
    if (selectedGender == Gender.male) {
      bmr = 66 + (6.23 * weight) + (12.7 * totalHeightInches) - (6.8 * age);
    } else if (selectedGender == Gender.female) {
      bmr = 655 + (4.35 * weight) + (4.7 * totalHeightInches) - (4.7 * age);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: appBar(),
      body: ListView(
        children: [
          Container(
            padding: REdgeInsets.all(16),
            margin: REdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorLighterGray,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What is BMR?",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: colorPrimary,
                  ),
                ),
                Gap(8.h),
                Text(
                  "The basal metabolic rate (BMR) is the amount of energy needed while resting in a temperate environment when the digestive system is inactive.",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: colorBlack,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
            margin: REdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: colorLighterGray,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Gender",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colorBlack,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    genderSection(Gender.male),
                    genderSection(Gender.female),
                  ],
                ),
              ],
            ),
          ),
          Gap(16.h),
          heightSection(),
          Row(
            children: [
              weightSection(),
              ageSection(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: REdgeInsets.all(16),
        child: MyButton(
          onPressed: () {
            calculateBMR();
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    backgroundColor: colorWhite,
                    insetPadding: REdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding:
                            REdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "BMR Result",
                              style: TextStyle(
                                color: colorBlack,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(8.h),
                            Text(
                              "$bmr",
                              style: TextStyle(
                                color: colorBlack,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(2.h),
                            Text(
                              "Calories per day",
                              style: TextStyle(
                                color: colorBlack,
                                fontSize: 20.sp,
                              ),
                            ),
                            Gap(16.h),
                            MyButton(
                                onPressed: () {
                                  Get.back();
                                },
                                text: "Close")
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          text: "Calculate BMR",
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 4,
      flexibleSpace: Container(
        color: colorPrimary, // Set a fixed color here
      ),
      titleSpacing: -1,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: SvgPicture.asset(
          back,
          height: 24.h,
          width: 24.w,
        ),
      ),
      title: Text(
        'BMR',
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: colorWhite,
        ),
      ),
    );
  }

  Expanded genderSection(Gender gender) {
    return Expanded(
      child: RadioListTile<Gender>(
        title: Text(gender == Gender.male ? "Male" : "Female"),
        value: gender,
        groupValue: selectedGender,
        onChanged: (value) {
          setState(() {
            selectedGender = value!;
          });
        },
        activeColor: gender == Gender.male ? colorBlue : colorPink,
      ),
    );
  }

  Container heightSection() {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: REdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colorLighterGray,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Height",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colorBlack,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '$heightFeet',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: colorBlack,
                ),
              ),
              Text(
                ' ft',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: colorBlack,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                '$heightInches',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: colorBlack,
                ),
              ),
              Text(
                ' in',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: colorBlack,
                ),
              ),
            ],
          ),
          Slider(
            value: sliderValue,
            onChanged: (value) {
              print(sliderValue);
              setState(() {
                sliderValue = value;
                heightFeet = value ~/ 12;
                heightInches = value.toInt() % 12;
              });
            },
            min: 0,
            max: 96, // Adjusted maximum value
            activeColor: colorPrimary,
            inactiveColor: Colors.grey[350],
          ),
        ],
      ),
    );
  }

  Expanded ageSection() {
    return Expanded(
      child: Container(
        padding: REdgeInsets.all(16),
        margin: REdgeInsets.only(top: 16, left: 8, right: 16, bottom: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r), color: colorLighterGray),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select Age",
              style: TextStyle(
                fontSize: 14.sp,
                color: colorBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '$age',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: colorBlack,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      age--;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: colorBlack,
                    radius: 15.r,
                    child: const Icon(
                      Icons.remove,
                      color: colorWhite,
                      size: 18,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      age++;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: colorBlack,
                    radius: 15.r,
                    child: const Icon(
                      Icons.add,
                      color: colorWhite,
                      size: 18,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Expanded weightSection() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: REdgeInsets.all(16),
        margin: REdgeInsets.only(top: 16, left: 16, right: 8, bottom: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r), color: colorLighterGray),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select Weight",
              style: TextStyle(
                fontSize: 14.sp,
                color: colorBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '$weight',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: colorBlack,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      weight--;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: colorBlack,
                    radius: 15.r,
                    child: const Icon(
                      Icons.remove,
                      color: colorWhite,
                      size: 18,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      weight++;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: colorBlack,
                    radius: 15.r,
                    child: const Icon(
                      Icons.add,
                      color: colorWhite,
                      size: 18,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
