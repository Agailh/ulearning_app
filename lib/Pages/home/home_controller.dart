import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/Pages/home/bloc/home_page_bloc.dart';
import 'package:ulearning_app/Pages/home/bloc/home_page_events.dart';
import 'package:ulearning_app/common/entities/entities.dart';


import '../../common/apis/course_api.dart';
import '../../global.dart';

class HomeController {
  late BuildContext context;
  
  UserItem? get userProfile => Global.storageService.getUserProfile();
  static final HomeController _singleton = HomeController._external();
  HomeController._external();
  // this is a factory constructor
  // make sure u have the original only one instance
  factory HomeController ({required BuildContext context}){
    _singleton.context = context;
    return _singleton;
  }

  Future<void> init() async {
  //make sure that user is logged and then make api call
   if (Global.storageService.getUserToken().isNotEmpty){
     var result = await CourseAPI.courseList();
     //print("the result is ${result.data![0].thumbnail!}");
   if(result.code==200){
    
      if(context.mounted){
        context.read<HomePagesBloc>().add(HomePageCourseItem(result.data!));
        return;
      }
    print("perfect");
   
   }else{
    print(result.code);
    return;
   }
   }else{
    print("user already log out");
   }
    return;
  }
}