
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ulearning_app/Pages/welcome/welcome.dart';


import 'package:ulearning_app/common/routes/routes.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/global.dart';





void main() async {
 await Global.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppPages.allProviders(context)],
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (Context, child) => MaterialApp(
            builder: EasyLoading.init(),
                debugShowCheckedModeBanner: false,
                theme: ThemeData(

                    appBarTheme: const AppBarTheme(
                      iconTheme: IconThemeData(
                        color: AppColors.primaryText
                      ),
                        elevation: 0, backgroundColor: Colors.white)),
                //home: const Welcome(),
                onGenerateRoute: AppPages.GenerateRouteSettings ,
                //initialRoute: "/",
                // routes: {
                //  // "myHomePage": (context) => const MyHomePage(),
                //   "signIn": (context) => const SignIn(),
                //   "register": (context )=> const Register(),
                // },
              )),
    );
  }
}
