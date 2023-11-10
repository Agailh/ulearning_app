import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/Pages/Profile/settings/bloc/settings_events.dart';
import 'package:ulearning_app/Pages/Profile/settings/bloc/settings_states.dart';

class SettingsBlocs extends Bloc<SettingsEvents, SettingStates>{
  SettingsBlocs():super(const SettingStates()){
    on<TriggerSettings>(_triggerSettings);
  }
  _triggerSettings(SettingsEvents events, Emitter<SettingStates> emit){
      emit(const SettingStates());
  }
}