import 'package:flutter/material.dart';

import 'appbar.dart';

class SecondView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSecond(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 40),
              child: textField(context),
            ),
            addButton()
          ],
        ),
      ),
    );
  }

  Widget addButton() {
    return TextButton.icon(
      // <-- TextButton
      onPressed: () {},
      style: TextButton.styleFrom(primary: Colors.black),
      icon: Icon(
        Icons.add,
        size: 25.0,
      ),
      label: Text('Add', style: TextStyle(fontSize: 16)),
    );
  }

  Widget textField(context) {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width *
            351 /
            411, // Satt boxen till samma proportioner som i figma
        decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: TextField());
  }
}
