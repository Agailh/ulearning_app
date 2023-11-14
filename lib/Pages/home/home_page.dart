// import 'dart:ffi';
// import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/Pages/home/bloc/home_page_bloc.dart';
import 'package:ulearning_app/Pages/home/bloc/home_page_states.dart';
import 'package:ulearning_app/Pages/home/home_controller.dart';
import 'package:ulearning_app/Pages/home/widgets/home_page_widgets.dart';
import 'package:ulearning_app/common/routes/routes.dart';
import 'package:ulearning_app/common/values/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late HomeController _homeController;

  @override 
  void initState(){
    super.initState();
    _homeController = HomeController(context: context);
    _homeController.init();
    
  }


  @override
  Widget build(BuildContext context) {
    return _homeController.userProfile!=null? Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(_homeController.userProfile!.avatar.toString()),
      body: BlocBuilder<HomePagesBloc, HomePageStates>(
        builder: (context, state){
          return Container(
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 25.w),
            child: CustomScrollView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              slivers: [
                SliverToBoxAdapter(
                  child: homePageText(
                    "hellow",
                    color: AppColors.primaryThridElementText,
                    top: 20,
                  ),
                ),
                SliverToBoxAdapter(
                  child: homePageText(
                    _homeController.userProfile!.name!,
                    top: 20,
                  ),
                ),
                SliverPadding(padding: EdgeInsets.only(top: 20.h),),
                SliverToBoxAdapter(
                  child: searchView(),
                ),
                SliverToBoxAdapter(
                  child: sliderView(context, state),
                ),
                SliverToBoxAdapter(
                  child: menuView(),
                ),
                SliverPadding(padding:
                EdgeInsets.symmetric(
                    vertical: 18.h,
                    horizontal: 0.w),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.6,

                  ),delegate: SliverChildBuilderDelegate(
                  childCount: state.courseItem.length,
                    (BuildContext context, int index){
                      return GestureDetector(
                        onTap: (){
                              Navigator.of(context).pushNamed(
                                AppRoutes.
                              );
                        },
                        child: courseGrid(state.courseItem[index])
                      );
                    }
                ),
                ),
                ),

              ],
            ),
          );
        },
      )
    ):Container();
  }
}
