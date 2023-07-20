import 'dart:ffi';

import 'package:angelus/logic/blocs/settings_bloc/models/SettingsModel.dart';
import 'package:angelus/logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:angelus/widgets/components/notification_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>{

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsModel>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Settings"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column (
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.prayerReminders.length,
                  itemBuilder: (context, index) {
                    return NotificationButton(
                        notificationTime: state.prayerReminders[index],
                        selectTime: _selectTime
                    );
                  }
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () =>  _selectTime(null), child: const Text("Add Reminder")
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  void _selectTime(TimeOfDay? timeOfDay) async {
    TimeOfDay initTime = timeOfDay ?? TimeOfDay.now();

    await showTimePicker(
        context: context,
        initialTime: initTime
    ).then((pickedTime){
      BlocProvider.of<SettingsBloc>(context).add(
        AddNotificationEvent(pickedTime!)
      );
      setState(() {

      });
    }
    );


  }
}