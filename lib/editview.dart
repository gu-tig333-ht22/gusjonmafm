import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appbar.dart';
import 'notifier.dart';

class EditView extends StatelessWidget {
  TextEditingController _myController = TextEditingController();
  EditView(String label) {
    _myController.text = label;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Edit TODO'),
      body: Center(
        child: Column(
          children: [
            Container(height: 40),
            textFieldContainer(context),
            Container(height: 40),
            editButtonEditView(context)
          ],
        ),
      ),
    );
  }

  Widget editButtonEditView(context) {
    return TextButton.icon(
      // <-- TextButton
      onPressed: () {
        validateInput(_myController.text, context);
      },
      style: TextButton.styleFrom(primary: Colors.black),
      icon: Icon(
        Icons.save,
        size: 25.0,
      ),
      label: Text('Save', style: TextStyle(fontSize: 16)),
    );
  }

  Widget textFieldContainer(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 351 / 411,
      child: Column(
        children: [textField(context), errorMessage()],
      ),
    );
  }

  Widget textField(context) {
    return Container(
        height: 50,
        // Satt boxen till samma proportioner som i figma
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: TextField(
          controller: _myController,
          onSubmitted: (value) {
            validateInput(_myController.text, context);
          },
        ));
  }

  Widget errorMessage() {
    return Consumer<MyErrorNotifier>(
        builder: (context, myChangeNotifier, child) => Align(
            alignment: Alignment.bottomLeft,
            child: Text(
                Provider.of<MyErrorNotifier>(context, listen: false)
                    .getErrorMessage,
                style: TextStyle(color: Colors.red))));
  }

  validateInput(String input, context) {
    if (input == '') {
      Provider.of<MyErrorNotifier>(context, listen: false)
          .setErrorMessage(true);
    } else {
      Provider.of<MyErrorNotifier>(context, listen: false)
          .setErrorMessage(false);
      Navigator.pop(context, input);
    }
  }
}
