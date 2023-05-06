import 'package:angelus/widgets/pages/angelus_screen/statistics_screen/statistics_screen.dart';
import 'package:angelus/widgets/pages/settings_screen/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AutoCloseDrawer extends StatelessWidget {
  const AutoCloseDrawer({super.key, this.width = 100,  this.onOptionTapped });
  final Function? onOptionTapped;
  final int width;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 100,
      child: Container(
        child: ListView(
          children:  [
            ListTile(
              title: Icon(FontAwesomeIcons.handsPraying),
              onTap: () {
                Navigator.pop(context);
              },

            ),
            ListTile(
              title: Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                if (onOptionTapped != null){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreens())
                  );
                }
              },
            ),
            ListTile(
              title: Icon(Icons.auto_graph),
              onTap: () {
                Navigator.pop(context);
                if (onOptionTapped != null){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StatisticsScreen())
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

}