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
        color: Theme.of(context).colorScheme.secondary,
        child: ListView(
          children:  [
            ListTile(
              title: Icon(FontAwesomeIcons.handsPraying),
              onTap: () {
                if (onOptionTapped != null){
                  onOptionTapped!(0);
                }
                Navigator.pop(context);
              },

            ),
            ListTile(
              title: Icon(Icons.settings),
              onTap: () {
                if (onOptionTapped != null){
                  onOptionTapped!(1);
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

}