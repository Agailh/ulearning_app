import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/Pages/common_widgets.dart';
import 'package:ulearning_app/common/values/colors.dart';

AppBar buildAppbar(){
  return AppBar(
    title: Container(
    child: Container(
      child:  reuseableText("setting")
    ),
    ),
  );
}

Widget settingsButton(BuildContext context, void Function()? func){
  return GestureDetector(
    onTap: (){
      showDialog(context: context, builder: (BuildContext context){
        return  AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("confirm logout"),
          actions: [
            TextButton(
                onPressed:()=> Navigator.of(context).pop()
                , child: const Text("cancel")),
            TextButton(
                onPressed:()=> func,
                child: const Text("confirm"))
          ],
        );
      });
    },
    child: Container(
      height: 100.h,
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage(
                  "assets/icons/Logout.png"
              )
          )
      ),
    ),
  );
}