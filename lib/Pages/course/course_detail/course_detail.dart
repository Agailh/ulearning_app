import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/Pages/course/course_detail/bloc/course_detail_blocs.dart';
import 'package:ulearning_app/Pages/course/course_detail/bloc/course_detail_states.dart';
import 'package:ulearning_app/Pages/course/course_detail/course_detail_controller.dart';
import 'package:ulearning_app/Pages/course/widgets/course_detail_widgets.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({Key? key}):super(key: key);

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  late CourseDetailController _courseDetailController;

  @override
  void initState(){
    super.initState();
    
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _courseDetailController = CourseDetailController(context: context);
    _courseDetailController.init();
  }


  @override
  Widget build(BuildContext context) {
    int i=0;
    return BlocBuilder<CourseDetailBloc, CourseDetailStates>(
        builder: (context, state){
          print("------state is called ------${++i}");
          return  state.courseItem==null? const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          ):Container(
              color: Colors.white,
              child: SafeArea(
                child:Scaffold(
                  backgroundColor: Colors.white,
                  appBar: buildAppBar("Course Detail"),
                  body: SingleChildScrollView(
                      child: Column(
                        children: [

                          Padding(padding: EdgeInsets.symmetric(vertical: 50.h , horizontal: 25.w),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //first beeg image
                                  thumbnail(state.courseItem!.thumbnail.toString()),
                                  SizedBox(height: 15.h,),
                                  //3 menu buttons
                                  menuView(),
                                  SizedBox(height: 15.h,),
                                  //title
                                  reuseableText("Course Description"),
                                  SizedBox(height: 15.h,),
                                  //desc course
                                  descriptionText(state.courseItem!.description.toString()),
                                  SizedBox(height: 20.h,),
                                  //buy button
                                  GestureDetector(
                                    onTap: (){
                                      _courseDetailController.goBuy(state.courseItem!.id);
                                    },
                                    child: goBuyButton("Go Buy"),
                                  ),
                                  //course summary
                                  SizedBox(height: 20.h,),
                                  courseSummaryTitle(),
                                  SizedBox(height: 20.h,),
                                  //build course
                                  courseSummaryView(context, state),
                                  SizedBox(height: 20.h,),
                                  //title lesson list
                                  reuseableText("Lesson List"),
                                  SizedBox(height: 20.h,),
                                  //course lesson list
                                  courseLessonList()

                                ]),
                          )
                        ],)),
                ),
              )
          );

        }
    );
    
  }
}