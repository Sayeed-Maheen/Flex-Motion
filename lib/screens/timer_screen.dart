import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../utils/app_colors.dart';
import '../utils/image_paths.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int duration = 60; // Default duration
  CountDownController controller = CountDownController();

  void setTimerDuration(int newDuration) {
    setState(() {
      duration = newDuration;
    });
    controller.restart(duration: newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 4,
        flexibleSpace: Container(
          color: colorPrimary, // Set a fixed color here
        ),
        title: Text(
          'Timer',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: colorWhite,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(timerBg),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: REdgeInsets.all(16),
                margin: REdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Timer Duration:',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: colorBlack,
                          ),
                        ),
                        Gap(8.w),
                        Text(
                          '$duration seconds',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: colorBlack,
                          ),
                        ),
                      ],
                    ),
                    Gap(16.h),
                    Container(
                      decoration: BoxDecoration(
                        color: colorSearchContainerBg,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          int? newDuration = int.tryParse(value);
                          if (newDuration != null) {
                            setTimerDuration(newDuration);
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: colorSearchContainerBg,
                          hintText: "Enter duration in seconds",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 14.sp,
                          ),
                          contentPadding: REdgeInsets.all(16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(
                              color: colorSearchContainerBg,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(
                              color: colorSearchContainerBg,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CircularCountDownTimer(
                duration: duration,
                controller: controller,
                width: 200.w,
                height: 200.h,
                ringColor: colorRing,
                ringGradient: null,
                fillColor: colorTimerFillColor,
                fillGradient: null,
                backgroundColor: colorTimerBg,
                backgroundGradient: null,
                strokeWidth: 6.w,
                strokeCap: StrokeCap.round,
                textStyle: TextStyle(
                  fontSize: 24.sp,
                  color: colorWhite,
                  fontWeight: FontWeight.bold,
                ),
                textFormat: CountdownTextFormat.MM_SS,
                isReverse: true,
                isReverseAnimation: false,
                isTimerTextShown: true,
                autoStart: false,
              ),
              Gap(16.h),
              InkWell(
                onTap: () {
                  if (duration > 0) {
                    controller.start();
                  }
                },
                child: Container(
                  width: 178.w,
                  height: 50.h,
                  padding: REdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: colorButtonDone,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: colorWhite,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Gap(16.h),
              InkWell(
                onTap: () {
                  controller.reset();
                },
                child: Container(
                  width: 178.w,
                  height: 50.h,
                  padding: REdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: colorButtonDone,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: colorWhite,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
