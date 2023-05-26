import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>{
  TimeOfDay morningAlarm = const TimeOfDay(hour: 6, minute: 0);

  TimeOfDay middayAlarm = const TimeOfDay(hour: 12, minute: 0);

  TimeOfDay eveningAlarm = const TimeOfDay(hour: 18, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column (
          children: [
            ElevatedButton(onPressed: () => _selectTime(1), child: Text(morningAlarm.format(context))),
            ElevatedButton(onPressed: () => _selectTime(2), child: Text(middayAlarm.format(context))),
              ElevatedButton(onPressed: () => _selectTime(3), child: Text(eveningAlarm.format(context)))

          ],
        ),
      ),
    );
  }

  void _selectTime(int alarmNumber) async {
    TimeOfDay pickedAlarm = morningAlarm;
    switch (alarmNumber) {
      case 1:
      {
        pickedAlarm = morningAlarm;
      }
      break;
      case 2:
      {
        pickedAlarm = middayAlarm;
      }
      break;
      case 3: {
        pickedAlarm = eveningAlarm;
      }
      break;
      default: {
        pickedAlarm = morningAlarm;
      }
     }

    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: pickedAlarm
    );
    setState(() {
      if (pickedTime != null) {
        switch (alarmNumber) {
          case 1:
            {
              morningAlarm = pickedTime;
            }
            break;
          case 2:
            {
              middayAlarm = pickedTime;
            }
            break;
          case 3:
            {
              eveningAlarm = pickedTime;
            }
            break;
          default:
            {
              morningAlarm = pickedTime;
            }
        }
      }
    });

  }
}