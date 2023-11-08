import 'dart:convert';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../utils/app_colors.dart';

class HealthTipsScreen extends StatefulWidget {
  const HealthTipsScreen({super.key});

  @override
  _HealthTipsScreenState createState() => _HealthTipsScreenState();
}

class _HealthTipsScreenState extends State<HealthTipsScreen> {
  List<Map<String, dynamic>> tips = [];
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    loadTips();
  }

  Future<void> loadTips() async {
    try {
      String tipsData = await rootBundle.loadString('assets/health_tips.json');
      List<dynamic> tipsJson = json.decode(tipsData);
      setState(() {
        tips = tipsJson.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      print('Error loading tips: $e');
    }
  }

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
          'Health Tips',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: colorWhite,
          ),
        ),
      ),
      body: tips.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : EnhanceStepper(
              currentStep: currentStep,
              stepIconSize: 20.h,
              onStepContinue: () {
                if (currentStep < tips.length - 1) {
                  setState(() {
                    currentStep++;
                  });
                }
              },
              onStepCancel: () {
                if (currentStep > 0) {
                  setState(() {
                    currentStep--;
                  });
                }
              },
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Padding(
                  padding: REdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: details.onStepContinue,
                        child: Container(
                          padding: REdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: colorWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gap(2.w),
                      TextButton(
                        onPressed: details.onStepCancel,
                        child: Text(
                          "Back",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: colorPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              steps: tips
                  .map(
                    (tip) => EnhanceStep(
                      isActive: currentStep == tips.indexOf(tip),
                      title: Text(
                        tip['title'],
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: colorBlack,
                        ),
                      ),
                      content: Container(
                        padding: REdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorLightestGray,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: colorLighterGray,
                            width: 1.w,
                          ),
                        ),
                        child: Text(
                          tip['description'],
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: colorBlack,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
