import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uxpros/utils/app_colors.dart';

import '../utils/image_paths.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final List<Widget> myTabs = [
    const Tab(text: 'All'),
    const Tab(text: 'Beginner'),
    const Tab(text: 'Intermediate'),
    const Tab(text: 'Advanced'),
  ];
  late TabController _tabController;
  int _tabIndex = 0;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  final List<String> _images = [
    trainingImage1,
    trainingImage2,
    trainingImage3,
    trainingImage4,
    trainingImage5,
  ];

  final List<String> _workoutName = [
    'ABS Workout',
    'Chest Workout',
    'Arms Workout',
    'Legs Workout',
    'Shoulder & Back',
  ];

  final List<String> _duration = [
    '2hour 20 minutes',
    '2hour 20 minutes',
    '2hour 20 minutes',
    '2hour 20 minutes',
    '2hour 20 minutes',
  ];

  final List<String> _typeBeginner = [
    'Beginner',
    'Beginner',
    'Beginner',
    'Beginner',
    'Beginner',
  ];

  final List<String> _typeIntermediate = [
    'Intermediate',
    'Intermediate',
    'Intermediate',
    'Intermediate',
    'Intermediate',
  ];

  final List<String> _typeAdvanced = [
    'Advanced',
    'Advanced',
    'Advanced',
    'Advanced',
    'Advanced',
  ];

  final List<String> _set = [
    '1/3',
    '1/3',
    '1/3',
    '1/3',
    '1/3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 120.h,
              decoration: const BoxDecoration(
                color: colorPrimary,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '12',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'WORKOUT',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '3',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'KCAL',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '2',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'MINUTES',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TabBar(
              isScrollable: true,
              dividerColor: Colors.transparent,
              controller: _tabController,
              labelColor: colorPrimary,
              tabs: myTabs,
            ),
            SizedBox(height: 12.h),
            Container(
              child: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'BEGINNER',
                        style: TextStyle(
                          color: colorLightGray,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ...List.generate(
                      _images.length,
                      (index) => Card(
                        shadowColor: colorLightGray,
                        margin:
                            REdgeInsets.only(left: 16, right: 16, bottom: 12),
                        elevation: 3,
                        child: Container(
                          height: 105.h,
                          width: double.infinity,
                          padding: REdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(_images[index]),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _workoutName[index],
                                style: TextStyle(
                                  color: colorWhite,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    timer,
                                    height: 16.h,
                                    width: 16.w,
                                    color: colorWhite,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    _duration[index],
                                    style: TextStyle(
                                      color: colorWhite,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                children: [
                                  Container(
                                    padding: REdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: colorBlack,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Text(
                                      _typeBeginner[index],
                                      style: TextStyle(
                                        color: colorWhite,
                                        fontSize: 11.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Container(
                                    padding: REdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: colorBlack,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Row(
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
                                            color: colorWhite,
                                            fontSize: 11.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'INTERMEDIATE',
                        style: TextStyle(
                          color: colorLightGray,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ...List.generate(
                      _images.length,
                      (index) => Card(
                        shadowColor: colorLightGray,
                        margin:
                            REdgeInsets.only(left: 16, right: 16, bottom: 12),
                        elevation: 3,
                        child: Container(
                          height: 105.h,
                          width: double.infinity,
                          padding: REdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(_images[index]),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _workoutName[index],
                                style: TextStyle(
                                  color: colorWhite,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    timer,
                                    height: 16.h,
                                    width: 16.w,
                                    color: colorWhite,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    _duration[index],
                                    style: TextStyle(
                                      color: colorWhite,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                children: [
                                  Container(
                                    padding: REdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: colorBlack,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Text(
                                      _typeIntermediate[index],
                                      style: TextStyle(
                                        color: colorWhite,
                                        fontSize: 11.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Container(
                                    padding: REdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: colorBlack,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Row(
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
                                            color: colorWhite,
                                            fontSize: 11.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'ADVANCED',
                        style: TextStyle(
                          color: colorLightGray,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ...List.generate(
                      _images.length,
                      (index) => Card(
                        shadowColor: colorLightGray,
                        margin:
                            REdgeInsets.only(left: 16, right: 16, bottom: 12),
                        elevation: 3,
                        child: Container(
                          height: 105.h,
                          width: double.infinity,
                          padding: REdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(_images[index]),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _workoutName[index],
                                style: TextStyle(
                                  color: colorWhite,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    timer,
                                    height: 16.h,
                                    width: 16.w,
                                    color: colorWhite,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    _duration[index],
                                    style: TextStyle(
                                      color: colorWhite,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                children: [
                                  Container(
                                    padding: REdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: colorBlack,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Text(
                                      _typeAdvanced[index],
                                      style: TextStyle(
                                        color: colorWhite,
                                        fontSize: 11.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Container(
                                    padding: REdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: colorBlack,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Row(
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
                                            color: colorWhite,
                                            fontSize: 11.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: List.generate(
                    _images.length,
                    (index) => Card(
                      shadowColor: colorLightGray,
                      margin: REdgeInsets.only(left: 16, right: 16, bottom: 12),
                      elevation: 3,
                      child: Container(
                        height: 105.h,
                        width: double.infinity,
                        padding:
                            REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(_images[index]),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _workoutName[index],
                              style: TextStyle(
                                color: colorWhite,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  timer,
                                  height: 16.h,
                                  width: 16.w,
                                  color: colorWhite,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  _duration[index],
                                  style: TextStyle(
                                    color: colorWhite,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Container(
                                  padding: REdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: colorBlack,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    _typeBeginner[index],
                                    style: TextStyle(
                                      color: colorWhite,
                                      fontSize: 11.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Container(
                                  padding: REdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: colorBlack,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Row(
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
                                          color: colorWhite,
                                          fontSize: 11.sp,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: List.generate(
                    _images.length,
                    (index) => Card(
                      shadowColor: colorLightGray,
                      margin: REdgeInsets.only(left: 16, right: 16, bottom: 12),
                      elevation: 3,
                      child: Container(
                        height: 105.h,
                        width: double.infinity,
                        padding:
                            REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(_images[index]),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _workoutName[index],
                              style: TextStyle(
                                color: colorWhite,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  timer,
                                  height: 16.h,
                                  width: 16.w,
                                  color: colorWhite,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  _duration[index],
                                  style: TextStyle(
                                    color: colorWhite,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Container(
                                  padding: REdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: colorBlack,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    _typeIntermediate[index],
                                    style: TextStyle(
                                      color: colorWhite,
                                      fontSize: 11.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Container(
                                  padding: REdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: colorBlack,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Row(
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
                                          color: colorWhite,
                                          fontSize: 11.sp,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: List.generate(
                    _images.length,
                    (index) => Card(
                      shadowColor: colorLightGray,
                      margin: REdgeInsets.only(left: 16, right: 16, bottom: 12),
                      elevation: 3,
                      child: Container(
                        height: 105.h,
                        width: double.infinity,
                        padding:
                            REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(_images[index]),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _workoutName[index],
                              style: TextStyle(
                                color: colorWhite,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  timer,
                                  height: 16.h,
                                  width: 16.w,
                                  color: colorWhite,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  _duration[index],
                                  style: TextStyle(
                                    color: colorWhite,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Container(
                                  padding: REdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: colorBlack,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    _typeAdvanced[index],
                                    style: TextStyle(
                                      color: colorWhite,
                                      fontSize: 11.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Container(
                                  padding: REdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: colorBlack,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Row(
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
                                          color: colorWhite,
                                          fontSize: 11.sp,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ][_tabIndex],
            ),
          ],
        ),
      ),
    );
  }
}
