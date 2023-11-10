import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:ulearning_app/common/service/storage_service.dart';

class Global{
  static late StorageService storageService;
  static Future init() async{
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();

    storageService = await StorageService().init();
  }

}