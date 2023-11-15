
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/Pages/Profile/settings/bloc/settings_bloc.dart';
import 'package:ulearning_app/Pages/Profile/settings/settings_page.dart';
import 'package:ulearning_app/Pages/application/application_page.dart';
import 'package:ulearning_app/Pages/application/bloc/app_blocs.dart';
import 'package:ulearning_app/Pages/course/bloc/course_blocs.dart';
import 'package:ulearning_app/Pages/course/course_detail/course_detail.dart';
import 'package:ulearning_app/Pages/home/bloc/home_page_bloc.dart';
import 'package:ulearning_app/Pages/home/home_page.dart';
import 'package:ulearning_app/Pages/register/bloc/register_blocs.dart';
import 'package:ulearning_app/Pages/register/register.dart';
import 'package:ulearning_app/Pages/sign_in/bloc/sign_in_blocs.dart';
import 'package:ulearning_app/Pages/sign_in/sign_in.dart';
import 'package:ulearning_app/Pages/welcome/bloc/welcome_blocs.dart';
import 'package:ulearning_app/Pages/welcome/welcome.dart';
import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/global.dart';




class AppPages{
 static List<PageEntity> routes(){
    return [
      PageEntity(
          route: AppRoutes.INITIAL,
          page: const Welcome(),
          bloc: BlocProvider(create: (_)=>WelcomeBloc(),)),
      PageEntity(
          route: AppRoutes.SIGN_IN,
          page: const SignIn(),
          bloc: BlocProvider(create: (_)=>SignInBloc(),)),
      PageEntity(
          route: AppRoutes.REGISTER,
          page: const Register(),
          bloc: BlocProvider(create: (_)=>RegisterBlocs(),)),
      PageEntity(
          route: AppRoutes.APPLICATION,
          page: const ApplicationPage(),
          bloc: BlocProvider(create: (_)=>AppBlocs(),)),
      PageEntity(
          route: AppRoutes.HOME_PAGE,
          page: const HomePage(),
          bloc: BlocProvider(create: (_)=>HomePagesBloc(),)),
      PageEntity(
          route: AppRoutes.SETTINGS,
          page: const SettingsPage(),
          bloc: BlocProvider(create: (_)=>SettingsBlocs(),)),
      PageEntity(
          route: AppRoutes.COURSE_DETAIL,
          page: const CourseDetail(),
          bloc: BlocProvider(create: (_)=>CourseDetailBloc(),)),

    ];
  }
  //return all bloc provider
   static List<dynamic> allProviders(BuildContext context){
   List<dynamic> blocProviders = <dynamic>[];
   for(var bloc in routes()){
      blocProviders.add(bloc.bloc);

   }
   return blocProviders;
 }
 // a modal that covers entire screen as we click on navigator object
  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings){
   if(settings.name!=null){
     //check for route name matching entire screen as we click on navigator object
     var result = routes().where((element)=>element.route==settings.name);

     if(result.isNotEmpty){
       print("first log");
       print(result.first.route);
       bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
       if(result.first.route==AppRoutes.INITIAL&&deviceFirstOpen){
         bool isLoggedin = Global.storageService.getIsloggedIn();
         if(isLoggedin){
           return MaterialPageRoute(builder: (_)=>const ApplicationPage(), settings: settings);
         }
         print("second log");
         return MaterialPageRoute(builder: (_)=>const SignIn(), settings: settings);
       }
        return MaterialPageRoute(builder: (_)=> result.first.page, settings: settings);
     }

   }
   print("invalid route name ${settings.name}" );
   return MaterialPageRoute(builder: (_)=>SignIn(), settings: settings);
  }
}



//unify BlocProvider and routes and pages
class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({
    required this.route,
    required this.page,
    required this.bloc,
  });

}
