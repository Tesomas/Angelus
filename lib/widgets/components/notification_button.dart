import 'package:angelus/logic/blocs/settings_bloc/models/SettingsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({
    super.key,
    required this.selectTime,
    required this.removeTime,
    required this.notificationTime
  }) : super();

  final void Function(TimeOfDay timeOfDay) selectTime;
  final void Function(TimeOfDay timeOfDay) removeTime;

  final TimeOfDay notificationTime;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => selectTime(notificationTime),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(notificationTime.format(
                    context)),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton(itemBuilder: (BuildContext context){
                  return [
                    const PopupMenuItem(
                        value: "delete",
                        child : Text("Delete")
                    )
                  ];
                },
                  onSelected: popupItemSelected,
                  child: const Icon(Icons.more_vert),
                )
              ],
            )
          ],
        )
    );
  }

  void popupItemSelected(String selected){
    if (selected == "delete"){
      removeTime(notificationTime);
    }
  }
}