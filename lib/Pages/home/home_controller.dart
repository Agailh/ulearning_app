import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/Pages/home/bloc/home_page_bloc.dart';
import 'package:ulearning_app/Pages/home/bloc/home_page_events.dart';
import 'package:ulearning_app/common/entities/entities.dart';


import '../../common/apis/course_api.dart';
import '../../global.dart';

class HomeController {
  final BuildContext context;
  HomeController ({required this.context});
  UserItem? userProfile = Global.storageService.getUserProfile();

  Future<void> init() async {
  //make sure that user is logged and then make api call
   if (Global.storageService.getUserToken().isNotEmpty){
     var result = await CourseAPI.courseList();
   if(result.code==200){
    
      if(context.mounted){
        context.read<HomePagesBloc>().add(HomePageCourseItem(result.data!));
      }
    print("perfect");
   
   }else{
    print(result.code);
   }
   }else{
    print("user already log out");
   }
    
  }
}