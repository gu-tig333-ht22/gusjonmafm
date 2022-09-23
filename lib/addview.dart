import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appbar.dart';
import 'notifier.dart';

class AddView extends StatelessWidget {
  TextEditingController _myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Add TODO'),
      body: Center(
        child: Column(
          children: [
            Container(height: 40),
            textField(context),
            Container(height: 40),
            addButtonAddView(context)
          ],
        ),
      ),
    );
  }

  Widget textField(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 351 / 411,
      child: Column(
        children: [
          Container(
              height: 50,
              // Satt boxen till samma proportioner som i figma
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                decoration: InputDecoration(hintText: 'Type in your todo'),
                controller: _myController,
                onSubmitted: (value) {
                  validateInput(_myController.text, context);
                },
              )),
          Consumer<MyErrorNotifier>(
              builder: (context, myChangeNotifier, child) => Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                      Provider.of<MyErrorNotifier>(context, listen: false)
                          .getErrorMessage,
                      style: TextStyle(color: Colors.red))))
        ],
      ),
    );
  }

  validateInput(String input, context) {
    if (input == '') {
      Provider.of<MyErrorNotifier>(context, listen: false)
          .setErrorMessage(true);
    } else {
      Provider.of<MyErrorNotifier>(context, listen: false)
          .setErrorMessage(false);
      Provider.of<MyChangeNotifier>(context, listen: false)
          .addTask(_myController.text);
      Navigator.pop(context);
    }
  }

  Widget addButtonAddView(context) {
    return TextButton.icon(
      onPressed: () {
        validateInput(_myController.text, context);
      },
      style: TextButton.styleFrom(primary: Colors.black),
      icon: Icon(Icons.add),
      label: Text('Add', style: TextStyle(fontSize: 16)),
    );
  }
}
