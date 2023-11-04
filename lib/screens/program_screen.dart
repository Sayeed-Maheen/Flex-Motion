import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../utils/app_colors.dart';
import '../utils/image_paths.dart';

class ProgramScreen extends StatelessWidget {
  final searchController = TextEditingController();
  final List<String> _fitnessName = [
    'Crunches',
    'Decline Crunch',
    'Dumbbell Side Bend',
    'Hanging Leg Raise',
    'Crunches',
    'Crunches',
  ];

  final List<String> _fitnessImages = [
    fitness1,
    fitness2,
    fitness3,
    fitness4,
    fitness5,
    fitness6,
  ];

  final List<String> _duration = [
    '1hour 20 minutes',
    '1hour 20 minutes',
    '1hour 20 minutes',
    '1hour 20 minutes',
    '1hour 20 minutes',
    '1hour 20 minutes',
  ];

  final List<String> _set = [
    '1/3',
    '1/3',
    '1/3',
    '1/3',
    '1/3',
    '1/3',
  ];
  ProgramScreen({super.key});

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
          'Abs Beginner',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: colorWhite,
          ),
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  margin: REdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colorGradient1Start,
                        colorGradient1End,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Only Four move for Abs',
                            style: TextStyle(
                              color: colorWhite,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Gap(8.h),
                          SizedBox(
                            width: 220.w,
                            child: Text(
                              'Four simple exercises only to burn belly and firm your core body',
                              maxLines: 3,
                              style: TextStyle(
                                color: colorWhite,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                      SvgPicture.asset(
                        questionMark,
                        height: 64.h,
                        width: 40.w,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: colorSearchContainerBg,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: TextFormField(
                    controller: searchController,
                    style: const TextStyle(color: colorBlack),
                    decoration: InputDecoration(
                      fillColor: colorSearchContainerBg,
                      hintText: "Search Exercises",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                        fontSize: 14.sp,
                      ),
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: REdgeInsets.all(16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.r),
                        borderSide: const BorderSide(
                          color: colorSearchContainerBg,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.r),
                        borderSide: const BorderSide(
                          color: colorSearchContainerBg,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(16.h),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.w / 2.h,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    _fitnessName.length,
                    (index) => InkWell(
                      onTap: () {
                        Get.toNamed("exercisesScreen");
                      },
                      child: Card(
                        shadowColor: colorLightGray,
                        elevation: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorWhite,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.r),
                                  topRight: Radius.circular(10.r),
                                ),
                                child: Image.asset(
                                  _fitnessImages[index],
                                  width: double.infinity,
                                  height: 80.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Gap(2.h),
                              SizedBox(
                                width: 130.w,
                                child: Center(
                                  child: Text(
                                    _fitnessName[index],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: colorBlack,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Gap(2.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    timer,
                                    height: 14.h,
                                    width: 14.w,
                                    color: colorBlack,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    _duration[index],
                                    style: TextStyle(
                                      color: colorBlack,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              Gap(4.h),
                              Container(
                                height: 20.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  color: colorLighterGray,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      lightning,
                                      height: 10.h,
                                      width: 10.w,
                                    ),
                                    SizedBox(width: 1.w),
                                    Text(
                                      _set[index],
                                      style: TextStyle(
                                        color: colorBlack,
                                        fontSize: 11.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(16.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
