import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notifier.dart';

class Dropdown extends StatefulWidget {
  @override
  State<Dropdown> createState() => DropdownState();
}

class DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyChangeNotifier>(
        builder: (context, myChangeNotifier, child) => DropdownButton<String>(
              value: myChangeNotifier.getDropdownValue,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              style: const TextStyle(color: Colors.black),
              onChanged: (String? valueDropdown) {
                //debugPrint(myChangeNotifier.getListTasks);
                myChangeNotifier.setDropdownValue = valueDropdown!;
              },
              items: myChangeNotifier.getDropdownValueList
                  .map<DropdownMenuItem<String>>((String valueDropdown) {
                return DropdownMenuItem<String>(
                  value: valueDropdown,
                  child: Text(valueDropdown),
                );
              }).toList(),
            ));
  }
}
