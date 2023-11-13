import 'package:flutter/cupertino.dart';
import 'package:ulearning_app/common/entities/entities.dart';


import '../../global.dart';

class HomeController {
  final BuildContext context;
  HomeController ({required this.context});
  UserItem? userProfile = Global.storageService.getUserProfile();

  void init(){
    print("..home controller init metod...");
  }
}