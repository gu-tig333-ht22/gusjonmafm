import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appbar.dart';
import 'notifier.dart';

class EditView extends StatelessWidget {
  final TextEditingController _myController = TextEditingController();
  EditView(String label) {
    _myController.text = label;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarAddEdit('Edit TODO'),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Backgroundimage.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
                decoration:
                    BoxDecoration(color: Color.fromARGB(220, 0, 28, 16))),
            Center(
              child: Column(
                children: [
                  Container(height: 40),
                  textField(context),
                  Container(height: 40),
                  editButtonEditView(context)
                ],
              ),
            ),
          ],
        ));
  }

  Widget editButtonEditView(context) {
    return ElevatedButton.icon(
      // <-- TextButton
      onPressed: () {
        validateInput(_myController.text, context);
      },
      style:
          ElevatedButton.styleFrom(primary: Color.fromARGB(100, 255, 255, 255)),
      icon: Padding(
        padding: const EdgeInsets.all(5.0),
        child: const Icon(
          Icons.save,
          size: 30.0,
        ),
      ),
      label: const Text('Save', style: TextStyle(fontSize: 16)),
    );
  }

  Widget textField(context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Color.fromARGB(100, 255, 255, 255),
            ),
            controller: _myController,
            onSubmitted: (value) {
              validateInput(_myController.text, context);
            },
          ),
          Consumer<MyErrorNotifier>(
              builder: (context, myChangeNotifier, child) => Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                      Provider.of<MyErrorNotifier>(context, listen: false)
                          .getErrorMessage,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 182, 87, 81)))))
        ],
      ),
    );
  }

  Widget errorMessage() {
    return Consumer<MyErrorNotifier>(
        builder: (context, myChangeNotifier, child) => Align(
            alignment: Alignment.bottomLeft,
            child: Text(
                Provider.of<MyErrorNotifier>(context, listen: false)
                    .getErrorMessage,
                style: const TextStyle(color: Colors.red))));
  }

  void validateInput(String input, context) {
    if (input == '') {
      Provider.of<MyErrorNotifier>(context, listen: false)
          .setErrorMessage(true);
    } else {
      Navigator.pop(context, input);
    }
  }
}
