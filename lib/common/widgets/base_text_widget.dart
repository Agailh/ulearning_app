import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';

Widget reuseableText(String text,
    {Color color = AppColors.primaryText,
      int fontSize = 16,
      FontWeight fontWeight = FontWeight.bold}) {
  return Container(
    child: Text(
      text,
      style: TextStyle(
          color: color, fontWeight: fontWeight, fontSize: fontSize.sp),
    ),
  );
}