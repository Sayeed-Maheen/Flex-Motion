import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'app_colors.dart';
import 'image_paths.dart';

class MyButton extends StatefulWidget {
  final void Function()?
      onPressed; // Callback function for when the button is pressed
  final String text; // Text to be displayed on the button

  const MyButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: colorPrimary, // Set the background color of the container
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: MaterialButton(
        height: 52.h,
        splashColor: Colors.transparent, // Set the splash color of the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        onPressed: widget
            .onPressed, // Set the callback function for when the button is pressed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              home,
              height: 20.h,
              width: 20.h,
            ),
            SizedBox(width: 8.w),
            Text(
              widget.text, // Display the text for the button
              style: TextStyle(
                color: colorWhite,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8.w),
            SvgPicture.asset(
              home,
              height: 20.h,
              width: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
