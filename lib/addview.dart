import 'package:flutter/material.dart';
import 'package:flutter_application_1/mainview_builder_notifier.dart';
import 'package:flutter_application_1/themes.dart';
import 'package:provider/provider.dart';

import 'appbar.dart';
import 'themes.dart';
import 'error_notifier.dart';

class AddView extends StatelessWidget {
  final TextEditingController _myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarAddEdit('Add TODO'),
      body: Stack(
        children: [
          backgroundImage(),
          filterBackgroundImage(),
          Center(
            child: Column(
              children: [
                Container(height: 40),
                textField(context),
                Container(height: 40),
                addButtonAddView(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget textField(context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            cursorColor: iconColor,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: borderRadius,
                ),
                filled: true,
                fillColor: boxColor,
                hintText: 'Type in your todo'),
            controller: _myController,
            onSubmitted: (value) {
              if (validateInput(_myController.text, context)) {
                Provider.of<MainviewNotifier>(context, listen: false)
                    .addTask(_myController.text);
                Navigator.pop(context);
              }
            },
          ),
          Consumer<MyErrorNotifier>(
              builder: (context, mainviewNotifier, child) =>
                  errorMessage(context))
        ],
      ),
    );
  }

  Widget addButtonAddView(context) {
    return ElevatedButton.icon(
      onPressed: () {
        if (validateInput(_myController.text, context)) {
          Provider.of<MainviewNotifier>(context, listen: false)
              .addTask(_myController.text);
          Navigator.pop(context);
        }
      },
      style: ElevatedButton.styleFrom(primary: appbarColor),
      icon: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            Icons.add,
            size: 20,
            color: Colors.white,
          )),
      label: const Text('Add', style: TextStyle(fontSize: 16)),
    );
  }
}
