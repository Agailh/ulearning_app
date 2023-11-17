import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/Pages/Profile/settings/bloc/settings_bloc.dart';
import 'package:ulearning_app/Pages/Profile/settings/bloc/settings_states.dart';
import 'package:ulearning_app/Pages/application/bloc/app_blocs.dart';
import 'package:ulearning_app/Pages/application/bloc/app_events.dart';
import 'package:ulearning_app/Pages/home/bloc/home_page_bloc.dart';
import 'package:ulearning_app/Pages/home/bloc/home_page_events.dart';
import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';
import 'package:ulearning_app/global.dart';
import '../settings/widgets/settings_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void removeUserData(){
    context.read<AppBlocs>().add(const TriggerAppEvent(0));
    context.read<HomePagesBloc>().add( const HomePageDots(0));
    Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
    Global.storageService.remove(AppConstants.STORAGE_USER_PROFILE_KEY);
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.SIGN_IN, (route) => false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar("Settings"),
      body: SingleChildScrollView(
        child: Container(
        child: BlocBuilder<SettingsBlocs, SettingStates>(
            builder: (context, sates){
              return  Column(
                children: [
                   settingsButton(context, removeUserData)
                ],
              );
            }
        )
        )

      ),
    );
  }
}
