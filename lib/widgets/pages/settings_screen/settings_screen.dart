
import 'package:angelus/logic/blocs/settings_bloc/models/SettingsModel.dart';
import 'package:angelus/logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:angelus/widgets/components/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
  const SettingsScreen({super.key});

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
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.prayerReminders.length,
                    itemBuilder: (context, index) {
                      return NotificationButton(
                          notificationTime: state.prayerReminders[index],
                          selectTime: _selectTime,
                          removeTime: _removeTime
                      );
                    }
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>  _selectTime(null), child: const Text("Add Reminder")
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () =>  _removeAllNotifications(), child: const Text("Clear Reminders")
                      ),
                    ]
                    ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  void _removeTime(TimeOfDay timeOfDay){
    BlocProvider.of<SettingsBloc>(context).add(
        RemoveNotificationEvent(timeOfDay)
    );
  }

  void _removeAllNotifications(){
    BlocProvider.of<SettingsBloc>(context).add(
        RemoveAllNotificationsEvent()
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
    }
    );
  }
}