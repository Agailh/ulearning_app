

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/Pages/course/lesson/bloc/lesson_blocs.dart';
import 'package:ulearning_app/Pages/course/lesson/bloc/lesson_events.dart';
import 'package:ulearning_app/Pages/course/lesson/bloc/lesson_states.dart';
import 'package:ulearning_app/Pages/course/lesson/lesson_controller.dart';
import 'package:ulearning_app/Pages/course/lesson/widgets/lesson_detail_widgets.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:video_player/video_player.dart';

class LessonDetail extends StatefulWidget {
  const LessonDetail({Key? key}) : super(key: key);

  @override
  State<LessonDetail> createState() => _LessonDetailState();
}

class _LessonDetailState extends State<LessonDetail> {
  int videoIndex=0;

  late LessonController _lessonController;
  @override
  void didChangeDependencies() {
    _lessonController = LessonController(context: context);
    context.read<LessonBlocs>().add(const TriggerUrlItem(null));
    context.read<LessonBlocs>().add(const TriggerVideoIndex(0));
    _lessonController.init();
    super.didChangeDependencies();
  }
  @override
    void dispose(){
    _lessonController.videoPlayerController?.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonBlocs, LessonStates> (builder: (context, state){
      return SafeArea(
        child: Container(
          color: Colors.white,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar("Lesson detail"),
            body: CustomScrollView(
              slivers: [
                SliverPadding(padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      //video preview
                      videoPlayer(state, _lessonController),
                      //video buttons
                      videoControl(state, _lessonController, context)
                    ],
                  ),
                ),

                ),
                videoList( state, _lessonController),

              ],
            ),
          ),
        ),
      );
    },);
  }
  Widget buildLessonItems(BuildContext context, int index, LessonVideoItem item){
    return Container(
      width: 325.w,
      height: 80.h,
      margin: EdgeInsets.only(
          bottom: 20.h
      ),
      padding: EdgeInsets.symmetric(vertical:10.h , horizontal: 10.w ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w),
          color: Color.fromRGBO(255, 255, 255, 1),

          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0,1)

            )
          ]

      ),
      child: InkWell(
        onTap: (){
        videoIndex =index;
        _lessonController.playVideo(item.url!);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [   Container(
                width: 60.h,
                height: 60.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.w),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage("${item.thumbnail}")
                    )
                ),
              ),
                Container(
                  width: 210.h,
                  height: 60.h,
                  alignment: Alignment.centerLeft,

                  margin: EdgeInsets.only(left: 6.sp),
                  child: reuseableText(

                      "${item.name}",
                      fontSize: 13.sp
                  ),
                )],
            ),
            Row(

              children: [
                Container(

                  child: GestureDetector(
                    onTap: (){
                      videoIndex =index;
                      _lessonController.playVideo(item.url!);
                    },
                    child: reuseableText("play", fontSize: 13.sp),
                  ),

                )
              ],
            )
          ],

        ),
      ),
    );
  }
}
