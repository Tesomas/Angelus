import 'dart:ffi';

import 'package:angelus/logic/blocs/settings_bloc/models/SettingsModel.dart';
import 'package:angelus/logic/blocs/settings_bloc/settings_bloc.dart';
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
                    return ElevatedButton(
                        onPressed: () => _selectTime(state, index),
                        child: Text(state.prayerReminders[index].format(
                            context)));

                  }
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () =>  _selectTime(state, null), child: const Text("Add Reminder")
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  void _selectTime(SettingsModel settingsState, int? index) async {
    TimeOfDay initTime = TimeOfDay.now();
    if (index != null){
      initTime = settingsState.prayerReminders[index];
    }
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initTime
    );

    if (index == null){
      settingsState.prayerReminders.add(pickedTime!);
    } else{
      settingsState.prayerReminders[index]=pickedTime!;
    }
    BlocProvider.of<SettingsBloc>(context).add(
      SettingsChangedEvent(settingsState),
    );
    setState(() {

    });

  }
}