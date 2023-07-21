import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class SettingsModel implements Equatable{
  final List<TimeOfDay> prayerReminders;
  SettingsModel(this.prayerReminders);

  factory SettingsModel.fromJSON(Map<String, dynamic> json){
    String jsonString = json["prayerReminders"];
    List<dynamic> timeStrings = jsonDecode(jsonString);
      List<TimeOfDay> reminders = timeStrings.map((e) =>
           TimeOfDay(hour: e["hour"]! , minute: e["minute"]!)
      ).toList();
      return SettingsModel(reminders);
  }

  Map<String, dynamic> toJSON(){
    Iterable<Object> reminderStrings = prayerReminders.map((e) =>
      {
        "hour": e.hour,
        "minute": e.minute
      }
    ).toList(growable: false);
      return {
        "prayerReminders":
          jsonEncode(reminderStrings)
      };
  }

  @override
  List<Object?> get props => [prayerReminders];

  @override
  bool? get stringify => true;

}