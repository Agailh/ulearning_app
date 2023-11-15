import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({Key? key}):super(key: key);

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  late var id;

  @override
  void initState(){
    super.initState();
    
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    id = ModalRoute.of(context)!.settings.arguments as Map;
    print(id.values.toString());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(id.values.toString()),
      ),
    );
    
  }
}