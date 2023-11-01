import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../utils/app_colors.dart';
import '../utils/image_paths.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final controller = CountDownController();
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
          '3 Months BodyBuilder',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: colorWhite,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              add,
              height: 22.h,
              width: 22.w,
            ),
          ),
        ],
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
              countDownTimer(context),
              Gap(8.h),
              Container(
                width: 178.w,
                height: 50.h,
                padding: REdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: colorButtonDone,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    'DONE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Gap(16.h),
              Container(
                width: 178.w,
                height: 50.h,
                padding: REdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: colorButtonSkip,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    'SKIP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Gap(50.h),
              Text(
                'Next 2/5',
                style: TextStyle(
                  color: colorWhite,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Cable Rope Upright ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    rotate,
                    height: 20.h,
                    width: 20.w,
                  ),
                  Gap(10.w),
                  Text(
                    'x4',
                    style: TextStyle(
                      color: colorWhite,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Gap(24.h),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 16),
                child: SvgPicture.asset(
                  gym,
                  width: 388.w,
                  height: 231.27.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget countDownTimer(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.start();
      },
      child: CircularCountDownTimer(
        duration: 60,
        controller: controller,
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 3,
        ringColor: colorRing,
        ringGradient: null,
        fillColor: colorTimerFillColor,
        fillGradient: null,
        backgroundColor: colorTimerBg,
        backgroundGradient: null,
        strokeWidth: 6.w,
        strokeCap: StrokeCap.round,
        textStyle: TextStyle(
            fontSize: 24.sp, color: Colors.white, fontWeight: FontWeight.bold),
        textFormat: CountdownTextFormat.MM_SS,
        isReverse: true,
        isReverseAnimation: false,
        isTimerTextShown: true,
        autoStart: false,
        onStart: () {
          debugPrint('Countdown Started');
        },
        onComplete: () {
          debugPrint('Countdown Ended');
        },
        onChange: (String timeStamp) {
          debugPrint('Countdown Changed $timeStamp');
        },
        timeFormatterFunction: (defaultFormatterFunction, duration) {
          if (duration.inSeconds == 0) {
            return "Rest";
          } else {
            return Function.apply(defaultFormatterFunction, [duration]);
          }
        },
      ),
    );
  }
}
