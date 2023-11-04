import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../utils/app_colors.dart';
import '../utils/image_paths.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen>
    with SingleTickerProviderStateMixin {
  final List<Widget> myTabs = [
    const Tab(text: 'Description'),
    const Tab(text: 'Steps'),
    const Tab(text: 'Targeted Muscle'),
  ];
  late TabController _tabController;
  int _tabIndex = 0;

  final videoURL = "https://www.youtube.com/watch?v=Eaw_ObFm1EM";
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      // onExitFullScreen: () {
      //   // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
      //   SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      // },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () => debugPrint('Ready'),
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              debugPrint('Settings Tapped!');
            },
          ),
        ],
      ),
      builder: (context, player) => Scaffold(
        backgroundColor: colorWhite,
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
            'Dips',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: colorWhite,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Dips',
                      style: TextStyle(
                        color: colorBlack,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding:
                              REdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: ShapeDecoration(
                            color: colorLighterGray,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            'Intermediate',
                            style: TextStyle(
                              color: colorBlack,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Gap(12.w),
                        Container(
                          padding:
                              REdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: ShapeDecoration(
                            color: colorLighterGray,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                lightning,
                                height: 9.h,
                                width: 9.w,
                              ),
                              Gap(4.w),
                              Text(
                                '1/3',
                                style: TextStyle(
                                  color: colorBlack,
                                  fontSize: 11.sp,
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
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 16),
                child: player,
              ),
              Gap(16.h),
              TabBar(
                isScrollable: true,
                dividerColor: Colors.transparent,
                controller: _tabController,
                labelColor: colorPrimary,
                tabs: myTabs,
              ),
              Gap(12.h),
              Container(
                child: [
                  Container(
                    padding: REdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      " Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                      maxLines: 5,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: colorBlack,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: REdgeInsets.all(16),
                          margin: REdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                            color: colorLighterGray,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(man1),
                              Text(
                                'Primary',
                                style: TextStyle(
                                  color: colorBlack,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Forearm',
                                style: TextStyle(
                                  color: colorPrimary,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Gap(16.w),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: REdgeInsets.all(16),
                          margin: REdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            color: colorLighterGray,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(man2),
                              Text(
                                'Secondary',
                                style: TextStyle(
                                  color: colorBlack,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Hip Flexors',
                                style: TextStyle(
                                  color: colorPrimary,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ][_tabIndex],
              ),
              Gap(16.h),
            ],
          ),
        ),
      ),
    );
  }
}
