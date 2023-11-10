import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/Pages/sign_in/bloc/sign_in_events.dart';
import 'package:ulearning_app/Pages/sign_in/bloc/signin_states.dart';

class SignInBloc extends Bloc<SignInEvent, SignInStates> {
  SignInBloc() : super(SignInStates()) {
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
  }
  void _emailEvent(EmailEvent event, Emitter<SignInStates> emit){
    print("my email is ${event.email}");
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignInStates> emit){
    print("password is ${event.password}");
    emit(state.copyWith(password: event.password));
  }

}
