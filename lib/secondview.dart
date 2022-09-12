import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appbar.dart';
import 'notifier.dart';
import 'main.dart';

class SecondView extends StatelessWidget {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSecond(),
      body: Center(
        child: Column(
          children: [
            Container(height: 40),
            textField(context),
            Container(height: 40),
            addButtonSecondView()
          ],
        ),
      ),
    );
  }

  Widget addButtonSecondView() {
    return Consumer<MyChangeNotifier>(
        builder: (context, myChangeNotifier, child) => TextButton.icon(
              // <-- TextButton
              onPressed: () {
                myChangeNotifier.addTask(myController.text);
                Navigator.pop(context);
                ;
              },
              style: TextButton.styleFrom(primary: Colors.black),
              icon: Icon(
                Icons.add,
                size: 25.0,
              ),
              label: Text('Add', style: TextStyle(fontSize: 16)),
            ));
  }

  Widget textField(context) {
    return Consumer<MyChangeNotifier>(
        builder: (context, myChangeNotifier, child) => Container(
            height: 50,
            width: MediaQuery.of(context).size.width *
                351 /
                411, // Satt boxen till samma proportioner som i figma
            decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: TextField(
              controller: myController,
              onSubmitted: (value) {
                myChangeNotifier.addTask(myController.text);
                Navigator.pop(context);
              },
            )));
  }
}
