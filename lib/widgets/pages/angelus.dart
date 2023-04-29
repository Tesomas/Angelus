import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrayerPage extends StatelessWidget {
  const PrayerPage({super.key});

  @override
  Widget build(BuildContext context){
    return  Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
          itemCount: angelusLines.length,
          itemBuilder: (context, index) {
            PrayerLine line = angelusLines[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: line.leaderLine ? Alignment.topLeft: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  constraints: const BoxConstraints(maxWidth: 275),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: line.leaderLine ?
                      Colors.grey.shade200:
                      Colors.orange.shade100

                  ),
                  child: Text(line.text,),
                ),
              ),
            );
          }),
      );
  }
}

class PrayerLine{
  const PrayerLine({required  this.text, required this.leaderLine});
  final String text;
  final bool leaderLine;
}

List<PrayerLine> angelusLines = [
  const PrayerLine(text: "The Angel of the Lord declared unto Mary",
      leaderLine: true),
  const PrayerLine(text: "And she conceived of the Holy Spirit",
      leaderLine: false),
  const PrayerLine(text: "Hail Mary, full of grace...",
      leaderLine: false),
  const PrayerLine(text: "Behold the handmaid of the Lord.",
      leaderLine: true),
  const PrayerLine(text: "Let it be done unto me according to Your Word.",
      leaderLine: false),
  const PrayerLine(text: "Hail Mary, full of grace...",
      leaderLine: false),
  const PrayerLine(text: "And the Word was made flesh",
      leaderLine: true),
  const PrayerLine(text: "And dwelt among us",
      leaderLine: false),
  const PrayerLine(text: "Hail Mary, full of grace...",
      leaderLine: false),
  const PrayerLine(text: "Pray for us, O holy Mother of God,",
      leaderLine: true),
  const PrayerLine(text: "That we may be made worthy of the promises of Christ.",
      leaderLine: false),
  const PrayerLine(text: "Pour forth, we beseech You, O Lord, Your Grace into our hearts; that as we have known the incarnation of Christ, your Son by the message of an angel, so by His passion and cross we may be brought to the glory of His Resurrection. Through the same Christ, our Lord. Amen. ",
      leaderLine: false),
];