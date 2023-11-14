import 'package:ulearning_app/common/entities/course.dart';

abstract class HomePagesEvents{
  const HomePagesEvents();

}
class HomePageDots extends HomePagesEvents{
  final int index;
  const HomePageDots(this.index):super();
}

class HomePageCourseItem extends HomePagesEvents {
  const HomePageCourseItem(this.courseItem);
  final List<CourseItem> courseItem; 
}