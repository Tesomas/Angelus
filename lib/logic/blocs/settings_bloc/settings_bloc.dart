import 'package:angelus/logic/blocs/settings_bloc/models/SettingsModel.dart';
import 'package:angelus/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
abstract class SettingsEvent{}

class SettingsChangedEvent extends SettingsEvent{
  SettingsModel settings;
  SettingsChangedEvent(this.settings);
}

class AddNotificationEvent extends SettingsEvent{
  TimeOfDay timeOfDay;
  AddNotificationEvent(this.timeOfDay);
}

class RemoveNotificationEvent extends SettingsEvent{
  TimeOfDay timeOfDay;
  RemoveNotificationEvent(this.timeOfDay);
}

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsModel> {
  SettingsModel? _settingsModel;
  SettingsBloc(): super(SettingsModel([])){
    on<SettingsChangedEvent>((event, emit){
      NotificationService().showPrayerNotification(event.settings);
      emit(event.settings);
    });
    on<AddNotificationEvent>((AddNotificationEvent event, emit){
      _settingsModel?.prayerReminders.firstWhere(
              (TimeOfDay notificationTime) => notificationTime == event.timeOfDay,
              orElse: () {
                  _settingsModel?.prayerReminders.add(event.timeOfDay);
                  return event.timeOfDay;
                }
      );
      emit(_settingsModel!);
    });
    on<RemoveNotificationEvent>((event, emit){
      _settingsModel?.prayerReminders.remove(event.timeOfDay);
      emit(_settingsModel!);

      //TODO: find any matching notifications and remove
    });
  }

  @override
  SettingsModel? fromJson(Map<String, dynamic> json) {
    _settingsModel = SettingsModel.fromJSON(json);
    return _settingsModel;
  }

  @override
  Map<String, dynamic>? toJson(SettingsModel state) {
    return state.toJSON();
  }



}