import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../controller/body_part_controller.dart';
import '../services/ad_services.dart';
import '../utils/app_colors.dart';
import '../utils/image_paths.dart';
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
  final InterstitialAdManager interstitialAdManager = InterstitialAdManager();

  @override
  void initState() {
    super.initState();
    fetchExercises();
    interstitialAdManager.createInterstitial();
  }

  Future<void> fetchExercises() async {
    String selectedBodyPart = _bodyPartController.selectedBodyPart.value;
    try {
      final response = await http.get(
          Uri.parse(
              'https://exercisedb.p.rapidapi.com/exercises/bodyPart/$selectedBodyPart'),
          headers: {
            'X-RapidAPI-Key':
                'c6db7f5f9dmsh3254f86410205b1p1490c9jsn64567251f578',
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

  @override
  void dispose() {
    super.dispose();
    interstitialAdManager.dispose();
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
          icon: SvgPicture.asset(
            back,
            height: 24.h,
            width: 24.w,
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
                    interstitialAdManager.showInterstitialAd();
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
              color: colorWhite,
            ),
            subtitle: Container(
              height: 12.0,
              color: colorWhite,
            ),
            leading: Container(
              width: 100.0,
              height: 100.0,
              color: colorWhite, // Shimmer background color
            ),
          ),
        );
      },
    );
  }
}
