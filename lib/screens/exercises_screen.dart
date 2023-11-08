import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../utils/app_colors.dart';
import '../utils/image_paths.dart';
import '../utils/strings.dart';

class ExercisesScreen extends StatefulWidget {
  final String name;
  final String gifUrl;
  final List<String> secondaryMuscles;
  final List<String> instructions;

  const ExercisesScreen(
      {super.key,
      required this.name,
      required this.gifUrl,
      required this.secondaryMuscles,
      required this.instructions});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  loadAd() {
    nativeAd = NativeAd(
        adUnitId: nativeAdsUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
            log("Ad Loaded");
          },
          onAdFailedToLoad: (ad, error) {
            isAdLoaded.value = false;
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.small));
    nativeAd!.load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightestGray,
      appBar: AppBar(
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
          capitalize(widget.name),
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: colorWhite,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            Obx(
              () => Container(
                child: isAdLoaded.value
                    ? ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 100,
                          minHeight: 100,
                        ),
                        child: AdWidget(ad: nativeAd!))
                    : const SizedBox(),
              ),
            ),
            Gap(16.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(widget.gifUrl),
            ),
            Gap(16.h),
            Text(
              'Secondary Muscles:',
              style: TextStyle(
                color: colorBlack,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.secondaryMuscles
                  .map((muscle) => Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 9.h,
                            color: colorCircle,
                          ),
                          Gap(4.w),
                          Text(capitalize(muscle)),
                        ],
                      ))
                  .toList(),
            ),
            Gap(16.h),
            Text(
              'Instructions:',
              style: TextStyle(
                color: colorBlack,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.instructions
                  .map((instruction) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: REdgeInsets.only(top: 4),
                            child: Icon(
                              Icons.circle,
                              size: 9.h,
                              color: colorCircle,
                            ),
                          ),
                          Gap(4.w),
                          SizedBox(
                            width: 300.w,
                            child: Text(
                              capitalize(instruction),
                              maxLines: 4,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: colorBlack,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
