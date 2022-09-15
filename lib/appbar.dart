import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notifier.dart';

const int figmaGrey = 0xffC4C4C4;

PreferredSize appBarMain(context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(48),
    child: AppBar(
      centerTitle: true,
      title: const Text(
        'TIG333 TODO-List',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 33, 84, 62),
      actions: [dropDownButton(context)],
    ),
  );
}

Widget dropDownButton(context) {
  List<String> list = Provider.of<MyChangeNotifier>(context, listen: false)
      .getDropdownValueList;
  return Consumer<MyChangeNotifier>(
      builder: (context, myChangeNotifier, child) =>
          DropdownButtonHideUnderline(
            child: DropdownButton(
                dropdownColor: Color.fromARGB(150, 33, 84, 62),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                value: Provider.of<MyChangeNotifier>(context, listen: false)
                    .getDropdownValue,
                icon: const Icon(Icons.filter_alt),
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  Provider.of<MyChangeNotifier>(context, listen: false)
                      .setDropdownValue = value!;
                }),
          ));
}

PreferredSize appBarAddEdit(String title) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(48),
    child: AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 33, 84, 62),
    ),
  );
}
