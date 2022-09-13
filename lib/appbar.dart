import 'package:flutter/material.dart';

import 'dropdownbuttons.dart';

const int figmaGrey = 0xffC4C4C4;

PreferredSize appBarMain() {
  return PreferredSize(
    preferredSize: Size.fromHeight(48),
    child: AppBar(
      centerTitle: true,
      title: const Text(
        'TIG333 TODO',
        style: TextStyle(fontSize: 26, color: Colors.black),
      ),
      backgroundColor: Color(figmaGrey),
      actions: [DropdownAppbar()],
    ),
  );
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
