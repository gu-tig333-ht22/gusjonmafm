import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'themes.dart';
import 'error_notifier.dart';

class EditView extends StatelessWidget {
  final TextEditingController _myController = TextEditingController();
  EditView(String label) {
    _myController.text = label;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Edit TODO',
            style: TextStyle(fontSize: fontsizeAppbar, color: textColor),
          ),
          backgroundColor: appbarColor,
        ),
        body: Stack(
          children: [
            backgroundImage(),
            filterBackgroundImage(),
            Center(
              child: Column(
                children: [
                  Container(height: 40),
                  _textField(context),
                  Container(height: 40),
                  _editButtonEditView(context)
                ],
              ),
            ),
          ],
        ));
  }

  Widget _editButtonEditView(context) {
    return ElevatedButton.icon(
      onPressed: () {
        if (validateInput(_myController.text, context)) {
          Navigator.pop(context, _myController.text);
        }
      },
      style: ElevatedButton.styleFrom(primary: appbarColor),
      icon: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Icon(
            Icons.save,
            size: 20,
            color: Colors.white,
          )),
      label: const Text('Save', style: TextStyle(fontSize: 16)),
    );
  }

  Widget _textField(context) {
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
            ),
            controller: _myController,
            onSubmitted: (value) {
              if (validateInput(_myController.text, context)) {
                Navigator.pop(context, _myController.text);
              }
            },
          ),
          Consumer<MyErrorNotifier>(
              builder: (context, myChangeNotifier, child) =>
                  errorMessage(context))
        ],
      ),
    );
  }
}
