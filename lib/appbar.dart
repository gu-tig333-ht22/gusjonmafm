import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mainview_builder_notifier.dart';
import 'themes.dart';

PreferredSize appBarMain(context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(sizeAppbar),
    child: AppBar(
      centerTitle: true,
      title: const Text(
        'TIG333 TODO-List',
        style: TextStyle(fontSize: fontsizeAppbar, color: textColor),
      ),
      backgroundColor: appbarColor,
      actions: [dropDownButton(context)],
    ),
  );
}

Widget dropDownButton(context) {
  return Consumer<MainviewNotifier>(
      builder: (context, mainviewNotifier, child) =>
          DropdownButtonHideUnderline(
            child: DropdownButton(
                dropdownColor: appbarColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                hint: Text(
                  Provider.of<MainviewNotifier>(context, listen: false)
                      .getDropdownValue,
                  style: TextStyle(color: textColor, fontSize: 12),
                ),
                icon: const Icon(
                  Icons.filter_alt_outlined,
                  color: iconColor,
                ),
                items: [
                  dropdownMenuItem('All', context),
                  dropdownMenuItem('Done', context),
                  dropdownMenuItem('Undone', context)
                ],
                onChanged: (String? value) {
                  Provider.of<MainviewNotifier>(context, listen: false)
                      .setDropdownValue = value!;
                }),
          ));
}

DropdownMenuItem<String> dropdownMenuItem(String value, context) {
  if (value ==
      Provider.of<MainviewNotifier>(context, listen: false).getDropdownValue) {
    return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: TextStyle(color: iconColor, fontSize: 12),
        ));
  } else {
    return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: TextStyle(color: textColor, fontSize: 12),
        ));
  }
}

PreferredSize appBarAddEdit(String title) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(sizeAppbar),
    child: AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(fontSize: fontsizeAppbar, color: textColor),
      ),
      backgroundColor: appbarColor,
    ),
  );
}
