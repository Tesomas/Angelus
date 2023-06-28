import 'package:angelus/logic/blocs/settings_bloc/models/SettingsModel.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
abstract class SettingsEvent{}

class SettingsChangedEvent extends SettingsEvent{
  SettingsModel settings;
  SettingsChangedEvent(this.settings);
}

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsModel> {
  SettingsBloc(): super(SettingsModel([])){
    on<SettingsChangedEvent>((event, emit){
      emit(event.settings);
    });
  }

  @override
  SettingsModel? fromJson(Map<String, dynamic> json) {
    return SettingsModel.fromJSON(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingsModel state) {
    return state.toJSON();
  }



}