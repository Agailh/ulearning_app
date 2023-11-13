

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/Pages/register/bloc/register_blocs.dart';
import 'package:ulearning_app/Pages/sign_in/bloc/sign_in_blocs.dart';
import 'package:ulearning_app/Pages/welcome/bloc/welcome_blocs.dart';


class AppBlocProviders{
  static get allBlocProviders=>[
    BlocProvider(create: (context) => WelcomeBloc()),
    //BlocProvider(create: (context) => AppBlocs()),
    BlocProvider(create: (context)=> SignInBloc()),
    BlocProvider(create: (context) => RegisterBlocs()),
  ];
}