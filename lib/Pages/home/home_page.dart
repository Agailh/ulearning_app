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
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/routes/routes.dart';
import 'package:ulearning_app/common/values/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserItem userProfile;
  // late HomeController _homeController;

  @override 
  void initState(){
    super.initState();
    //_homeController = HomeController(context: context);
   // _homeController.init();
   
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    userProfile = HomeController(context: context).userProfile!;

  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(userProfile.avatar.toString()),
      body: RefreshIndicator(
          onRefresh: (){
              return HomeController(context: context).init();
          },
        child: BlocBuilder<HomePagesBloc, HomePageStates>(
          builder: (context, state){
            if(state.courseItem.isEmpty){
              HomeController(context: context).init();
            }else{
              print("##############state.course is not empty");
            }
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
                     userProfile.name ?? "",
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
                                  AppRoutes.COURSE_DETAIL,
                                  arguments: {
                                    "id":state.courseItem.elementAt(index).id
                                  }
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
        ),
      )
    );//:Container();
  }
}
