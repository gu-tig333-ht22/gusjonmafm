import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appbar.dart';
import 'notifier.dart';

class AddView extends StatelessWidget {
  final TextEditingController _myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarAddEdit('Add TODO'),
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
              decoration: BoxDecoration(color: Color.fromARGB(220, 0, 28, 16))),
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
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Color.fromARGB(100, 255, 255, 255),
                hintText: 'Type in your todo'),
            controller: _myController,
            onSubmitted: (value) {
              validateInput(_myController.text, context);
            },
          ),
          Consumer<MyErrorNotifier>(
              builder: (context, myChangeNotifier, child) => Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        Provider.of<MyErrorNotifier>(context, listen: false)
                            .getErrorMessage,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 182, 87, 81))),
                  )))
        ],
      ),
    );
  }

  validateInput(String input, context) {
    if (input == '') {
      Provider.of<MyErrorNotifier>(context, listen: false)
          .setErrorMessage(true);
    } else {
      Provider.of<MyChangeNotifier>(context, listen: false)
          .addTask(_myController.text);
      Navigator.pop(context);
    }
  }

  Widget addButtonAddView(context) {
    return ElevatedButton.icon(
      onPressed: () {
        validateInput(_myController.text, context);
      },
      style:
          ElevatedButton.styleFrom(primary: Color.fromARGB(100, 255, 255, 255)),
      icon: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Icon(Icons.add_circle_sharp, size: 30),
      ),
      label: const Text('Add', style: TextStyle(fontSize: 16)),
    );
  }
}
