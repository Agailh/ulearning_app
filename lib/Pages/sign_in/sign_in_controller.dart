import 'dart:convert';
//import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ulearning_app/Pages/sign_in/bloc/sign_in_blocs.dart';
import 'package:ulearning_app/common/apis/user_api.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:ulearning_app/global.dart';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  Future<void> handleSignIn(String type) async {
    try {
      if (type == "email") {
        //Blockprovider.of<SignInBloc>(context).state
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;
        if (emailAddress.isEmpty) {
          //
          toastInfo(msg: "You need to fill email address");
          return;
        }

        if (password.isEmpty) {
          toastInfo(msg: "Need to fill the password");
          return;
          //
        }


        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
              email: emailAddress, password: password);
          if (credential.user == null) {
            //
            toastInfo(msg: "you didnt exist");
            return;
          }
          // if (credential.user!.emailVerified) {
          //   toastInfo(msg: "you need to verify email account");
          //   return;
          //   //
          // }
          var user = credential.user;
          if (user != null) {
            String? displayName = user.displayName;
            String? email = user.email;
            String? id = user.uid;
            String? photoUrl = user.photoURL;
            print("my url is ${photoUrl}");

            LoginRequestEntity loginRequestEntity = LoginRequestEntity();
            loginRequestEntity.avatar = photoUrl;
            loginRequestEntity.name = displayName;
            loginRequestEntity.email= email;
            loginRequestEntity.open_id= id;
            // type 1 is email login
            loginRequestEntity.type = 1;



            print("user exist");
            asyncPostAllData(loginRequestEntity);
           // Global.storageService.setString(AppConstants.STORAGE_USER_TOKEN_KEY, "123456");
           // Navigator.of(context).pushNamedAndRemoveUntil("/application", (route) => false);
            //verified user from firebase
          } else {
            toastInfo(msg: "currently you are not user");
            return;
            //we have error user from firebase
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            toastInfo(msg: "No user found for that email");
          } else if (e.code == 'wrong-password') {
            toastInfo(msg: "wrong password provided for that user");
          } else if (e.code == "invalid-email") {
            toastInfo(msg: "your email format is wrong");
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
      EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true
      );
      var result = await UserAPI.login(params:loginRequestEntity);
      if(result.code==200){
        try{
          Global.storageService.setString((AppConstants.STORAGE_USER_PROFILE_KEY), jsonEncode(result.data!));
          Global.storageService.setString(AppConstants.STORAGE_USER_TOKEN_KEY, result.data!.access_token!);
          EasyLoading.dismiss();
          Navigator.of(context).pushNamedAndRemoveUntil("/application", (route) => false);
        }catch (e){
          print("saving local storeage error ${e.toString()}");
        }
      }else{
        EasyLoading.dismiss();
        toastInfo(msg: "unknown error");
      }
  }
}
