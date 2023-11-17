import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:ulearning_app/Pages/course/course_detail/bloc/course_detail_blocs.dart';
import 'package:ulearning_app/Pages/course/course_detail/bloc/course_detail_events.dart';
import 'package:ulearning_app/common/apis/lesson_api.dart';

import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';

import '../../../common/apis/course_api.dart';

class CourseDetailController{
  final BuildContext context;
  CourseDetailController({
    required this.context
  });
  void init() async{
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    asyncLoadCourseData(args["id"]);
    asyncLoadLessonData(args["id"]);
  }
  asyncLoadCourseData(int? id)async{
    CourseRequestEntity courseRequestEntity = CourseRequestEntity();
    courseRequestEntity.id = id;
   var result = await CourseAPI.courseDetail(params:courseRequestEntity);
   if(result.code ==200){
     if(context.mounted){
       print("+++++++++++++++++context is ready");
       context.read<CourseDetailBloc>().add(TriggerCourseDetail(result.data!));
     }else{
       print("context is not avaliable");

     }

   }else{
    toastInfo(msg: "samting wen wong");
    print('-----------------------------Error code ${result.code}-----------------------------');
   }
  }

    asyncLoadLessonData(int? id) async {
    LessonRequestEntity lessonRequestEntity = LessonRequestEntity();
    lessonRequestEntity.id = id;
    var result = await LessonAPI.lessonList(params:lessonRequestEntity);
    print('-----my lesson data ${result.data?.length.toString()}-------');
    if(result.code==200){
     if(context.mounted){
       context.read<CourseDetailBloc>().add(TriggerLessonList(result.data!));
       print('my lesson data is ${result.data![1].description}');
     }
      else{
        print("----context is not read -----");
     }
    } else {
      toastInfo(msg: "something went wong check the log laravel.log");
    }
    }



  Future<void> goBuy(int? id) async {
    print('course id is ${id}');
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true
    );
   CourseRequestEntity courseRequestEntity = CourseRequestEntity();
    courseRequestEntity.id=id;
    var result = await CourseAPI.coursePay(params: courseRequestEntity);
    EasyLoading.dismiss();
    if(result.code==200){
      var url = Uri.decodeFull(result.data!);
      var res = await Navigator.of(context).pushNamed(AppRoutes.PAY_WEB_VIEW, arguments: {
        "url":url
      });
      // print("--------my return stripe url is $url---------");
  if(res=="succes"){
    toastInfo(msg: result.msg!);
  }
    }else{
    toastInfo(msg: result.msg!);
    }
  }
}