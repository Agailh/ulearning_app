import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/Pages/course/bloc/course_blocs.dart';
import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';

import '../../../common/apis/course_api.dart';

class CourseDetailController{
  final BuildContext context;
  CourseDetailController({
    required this.context
  });
  void init() async{
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    asyncLoadAllData(args["id"]);
  }
  asyncLoadAllData(int? id)async{
    CourseRequestEntity courseRequestEntity = CourseRequestEntity();
    courseRequestEntity.id = id;
   var result = await CourseAPI.courseDetail(params:courseRequestEntity);
   if(result.code ==200){
    //context.read<CourseDetailBloc
   }else{
    toastInfo(msg: "samting wen wong");
    print('-----------------------------Error code ${result.code}-----------------------------');
   }
  }
}