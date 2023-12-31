import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';

import '../services/api_services.dart';
import '../utils/app_colors.dart';
import '../utils/image_paths.dart';
import '../utils/strings.dart';
import 'exercises_screen.dart';

class ProgramScreen extends StatefulWidget {
  const ProgramScreen({super.key});

  @override
  State<ProgramScreen> createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen> {
  final searchController = TextEditingController();

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> exercises = [];
  List<Map<String, dynamic>> filteredExercises = [];
  int currentPage = 1;

  // ---- Interstitial Ad ---- //
  InterstitialAd? interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  @override
  void initState() {
    super.initState();
    fetchData(currentPage);
    createInterstitial(); // Interstitial Ad
  }

  Future<void> fetchData(int page) async {
    try {
      List<Map<String, dynamic>> data =
          await _apiService.fetchExercisesByPage(page);
      setState(() {
        exercises.addAll(data);
        filteredExercises.addAll(data);
        currentPage++;
      });
    } catch (e) {
      print('Error: $e');
      // Handle error, show error message, etc.
    }
  }

  Future<void> loadMoreData() async {
    await fetchData(currentPage);
  }

  void filterExercises(String searchTerm) {
    setState(() {
      filteredExercises = exercises.where((exercise) {
        String name = exercise['name'].toString().toLowerCase();
        return name.contains(searchTerm.toLowerCase());
      }).toList();
    });
  }

  // ---- Interstitial Ad functions----
  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  // ---- Interstitial Ad functions---- //
  void createInterstitial() {
    InterstitialAd.load(
      adUnitId:
          Platform.isAndroid ? interstitialAdUnitId : interstitialAdUnitId,
      request: request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print("Ad Loaded");
          interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print("Ad Failed to Load");
          interstitialAd = null;
          _numInterstitialLoadAttempts += 1;
          if (_numInterstitialLoadAttempts < 3) {
            createInterstitial();
          }
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (interstitialAd == null) {
      print('Warning: attempt to show interstitialAd before loaded.');
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitial();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitial();
      },
    );

    interstitialAd!.setImmersiveMode(true);
    interstitialAd!.show(
        //     onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        //   print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
        // }
        );
    interstitialAd = null;
  }

  @override
  void dispose() {
    super.dispose();
    interstitialAd?.dispose(); // Interstitial Ad
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
          programs,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: colorWhite,
          ),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            // User has reached the end of the list, load more data
            loadMoreData();
          }
          return true;
        },
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            children: [
              ListView(
                children: [
                  Container(
                    padding:
                        REdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                              fourMoves,
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
                                fourMovesDesc,
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
                      onChanged: (value) {
                        filterExercises(value);
                      },
                      decoration: InputDecoration(
                        fillColor: colorSearchContainerBg,
                        hintText: searchExercises,
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
                  if (searchController.text.isNotEmpty)
                    Container(
                      margin: REdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: colorLighterGray,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          filteredExercises.length,
                          (index) {
                            var exercise = filteredExercises[index];
                            return Column(children: [
                              InkWell(
                                onTap: () {
                                  _showInterstitialAd();
                                  Get.to(ExercisesScreen(
                                    name: exercise['name'],
                                    gifUrl: exercise['gifUrl'],
                                    secondaryMuscles: List<String>.from(
                                        exercise['secondaryMuscles']),
                                    instructions: List<String>.from(
                                        exercise['instructions']),
                                  ));
                                },
                                child: ListTile(
                                    title: Text(
                                  exercise['name'],
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: colorBlack,
                                  ),
                                )),
                              ),
                              if (index != filteredExercises.length - 1)
                                Padding(
                                  padding:
                                      REdgeInsets.symmetric(horizontal: 16),
                                  child: Divider(
                                    color: colorLightGray,
                                    height: 1.h,
                                  ),
                                ),
                            ]);
                          },
                        ),
                      ),
                    ),
                  Gap(16.h),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 2 / 2.4,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(exercises.length + 1, (index) {
                      if (index < exercises.length) {
                        var exercise = exercises[index];
                        return InkWell(
                          onTap: () {
                            Get.to(ExercisesScreen(
                              name: exercise['name'],
                              gifUrl: exercise['gifUrl'],
                              secondaryMuscles: List<String>.from(
                                  exercise['secondaryMuscles']),
                              instructions:
                                  List<String>.from(exercise['instructions']),
                            ));
                          },
                          child: Card(
                            shadowColor: colorLighterGray,
                            margin: EdgeInsets.zero,
                            elevation: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorLightestGray,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.r),
                                      topRight: Radius.circular(10.r),
                                    ),
                                    child: Image.network(
                                      exercise['gifUrl'],
                                      width: double.infinity,
                                      height: 90.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Gap(4.h),
                                  SizedBox(
                                    width: 120.w,
                                    child: Center(
                                      child: Text(
                                        capitalize(exercise['name']),
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
                                        target,
                                        height: 10.h,
                                        width: 10.w,
                                      ),
                                      Gap(4.w),
                                      Text(
                                        capitalize(exercise['bodyPart']),
                                        style: TextStyle(
                                          color: colorBlack,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(4.h),
                                  Container(
                                    padding: REdgeInsets.symmetric(
                                        horizontal: 6, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: colorLighterGray,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          equipment,
                                          height: 10.h,
                                          width: 10.w,
                                        ),
                                        Gap(4.w),
                                        Text(
                                          capitalize(exercise['equipment']),
                                          style: TextStyle(
                                            color: colorBlack,
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
                            ),
                          ),
                        );
                      } else {
                        // Loading indicator (shimmer effect)
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300] ??
                              Colors.grey, // Use default color if null
                          highlightColor: Colors.grey[100] ?? Colors.grey,
                          child: Card(
                            color: colorWhite,
                            elevation: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorWhite,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height:
                                        14.sp, // Set height for shimmer effect
                                    color: colorWhite,
                                  ),
                                  Gap(4.h),
                                  Container(
                                    width: double.infinity,
                                    height:
                                        14.sp, // Set height for shimmer effect
                                    color: colorWhite,
                                  ),
                                  Gap(4.h),
                                  Container(
                                    width: double.infinity,
                                    height:
                                        14.sp, // Set height for shimmer effect
                                    color: colorWhite,
                                  ),
                                  Gap(4.h),
                                  Container(
                                    width:
                                        100.w, // Set width for shimmer effect
                                    height:
                                        100.h, // Set height for shimmer effect
                                    color: colorWhite,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
