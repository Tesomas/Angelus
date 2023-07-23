
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

class RemoveAllNotificationsEvent extends SettingsEvent{
  RemoveAllNotificationsEvent();
}
class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsModel> {
  SettingsBloc(): super(SettingsModel(const [])){
    on<SettingsChangedEvent>((event, emit){
      NotificationService().showPrayerNotification(event.settings);
      emit(event.settings);
    });

    on<AddNotificationEvent>((AddNotificationEvent event, emit){

      final List<TimeOfDay> prayerReminders = [];
      prayerReminders.addAll(
          state.prayerReminders);


      prayerReminders.firstWhere(
              (TimeOfDay notificationTime) => notificationTime == event.timeOfDay,
              orElse: () {
                  prayerReminders.add(event.timeOfDay);
                  return event.timeOfDay;
                }
      );
      sortPrayerReminders(prayerReminders);
      emit(SettingsModel(prayerReminders));
      NotificationService().showPrayerNotification(state);

    });

    on<RemoveNotificationEvent>((event, emit){
      final List<TimeOfDay> prayerReminders = [];
      prayerReminders.addAll(
          state.prayerReminders);
      prayerReminders.remove(event.timeOfDay);
      sortPrayerReminders(prayerReminders);
      emit(SettingsModel(prayerReminders));
      NotificationService().showPrayerNotification(state);
    });

    on<RemoveAllNotificationsEvent>((event, emit){
      final List<TimeOfDay> prayerReminders = [];
      emit(SettingsModel(prayerReminders));
      NotificationService().showPrayerNotification(state);
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
  
   void sortPrayerReminders(List<TimeOfDay> prayerReminders){
    prayerReminders.sort((a, b){
      int hourCompare = a.hour.compareTo(b.hour);
      if (hourCompare != 0){
        return hourCompare;
      } else {
        return a.minute.compareTo(b.minute);
      }
    });
  }


}