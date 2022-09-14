import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notifier.dart';

const int figmaGrey = 0xffC4C4C4;

PreferredSize appBarMain(context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(48),
    child: AppBar(
      centerTitle: true,
      title: const Text(
        'TIG333 TODO',
        style: TextStyle(fontSize: 26, color: Colors.black),
      ),
      backgroundColor: Color(figmaGrey),
      actions: [dropDownButton(context)],
    ),
  );
}

Widget dropDownButton(context) {
  List<String> list = Provider.of<MyChangeNotifier>(context, listen: false)
      .getDropdownValueList;
  return DropdownButton(
      value: Provider.of<MyChangeNotifier>(context, listen: false)
          .getDropdownValue,
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        Provider.of<MyChangeNotifier>(context, listen: false).setDropdownValue =
            value!;
      });
}

PreferredSize appBarSecond() {
  return PreferredSize(
    preferredSize: Size.fromHeight(48),
    child: AppBar(
      centerTitle: true,
      title: const Text(
        'TIG333 TODO',
        style: TextStyle(fontSize: 26, color: Colors.black),
      ),
      backgroundColor: Color(figmaGrey),
    ),
  );
}
