import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../controller/body_part_controller.dart';
import '../utils/app_colors.dart';
import '../utils/strings.dart';
import 'exercises_screen.dart';

class HomeDetailsScreen extends StatefulWidget {
  final int numItems;
  final String workoutName;
  const HomeDetailsScreen(
      {super.key, required this.numItems, required this.workoutName});

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  final BodyPartController _bodyPartController = Get.find();
  List<Map<String, dynamic>> exercises = [];

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  // ---- Interstitial Ad ---- //
  InterstitialAd? interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  @override
  void initState() {
    super.initState();
    fetchExercises();
    createInterstitial(); // Interstitial Ad
  }

  Future<void> fetchExercises() async {
    String selectedBodyPart = _bodyPartController.selectedBodyPart.value;
    try {
      final response = await http.get(
          Uri.parse(
              'https://exercisedb.p.rapidapi.com/exercises/bodyPart/$selectedBodyPart'),
          headers: {
            'X-RapidAPI-Key':
                '80220bfb6amshb35a1079de116b6p1d5440jsn5e32ae11893b',
            'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
          });
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          exercises = data.cast<Map<String, dynamic>>();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      // Handle error, show error message, etc.
    }
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
    String workoutName = widget.workoutName;
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: colorWhite,
          ),
        ),
        titleSpacing: -1,
        title: Text(
          workoutName,
          style: const TextStyle(
            color: colorWhite,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: exercises.isNotEmpty
          ? ListView.builder(
              itemCount: exercises.length > widget.numItems
                  ? widget.numItems
                  : exercises.length,
              padding: REdgeInsets.only(left: 16, right: 16, top: 16),
              itemBuilder: (context, index) {
                var exercise = exercises[index];
                return InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    _showInterstitialAd();
                    // Navigate to ExerciseDetailsScreen when a card is tapped
                    Get.to(
                      ExercisesScreen(
                        name: exercise['name'],
                        gifUrl: exercise['gifUrl'],
                        secondaryMuscles:
                            List<String>.from(exercise['secondaryMuscles']),
                        instructions:
                            List<String>.from(exercise['instructions']),
                      ),
                    );
                  },
                  child: Padding(
                    padding: REdgeInsets.only(bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorLightestGray,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: colorLighterGray,
                          width: 1.w,
                        ),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r),
                            ),
                            child: Image.network(
                              exercise['gifUrl'],
                              height: 90.h,
                              width: 90.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Gap(16.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 200.w,
                                child: Text(
                                  capitalize(exercise['name']),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: colorBlack,
                                  ),
                                ),
                              ),
                              Gap(8.h),
                              Text('Target: ${capitalize(exercise['target'])}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : const ShimmerLoadingEffect(),
    );
  }
}

class ShimmerLoadingEffect extends StatelessWidget {
  const ShimmerLoadingEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Number of shimmer items you want to show
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            title: Container(
              height: 16.0,
              color: Colors.white,
            ),
            subtitle: Container(
              height: 12.0,
              color: Colors.white,
            ),
            leading: Container(
              width: 100.0,
              height: 100.0,
              color: Colors.white, // Shimmer background color
            ),
          ),
        );
      },
    );
  }
}
