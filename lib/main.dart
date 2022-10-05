import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addview.dart';
import 'editview.dart';
import 'mainview_builder_notifier.dart';
import 'themes.dart';
import 'error_notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainviewNotifier()),
        ChangeNotifierProvider(create: (context) => MyErrorNotifier())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainView(),
          theme: themeData),
    );
  }
}

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _addButtonFirstView(context),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'TIG333 TODO-List',
            style: TextStyle(fontSize: fontsizeAppbar, color: textColor),
          ),
          backgroundColor: appbarColor,
          actions: [_dropDownButton(context)],
        ),
        body: Stack(
          children: [
            backgroundImage(),
            filterBackgroundImage(),
            Material(
                color: Color.fromARGB(0, 255, 255, 255),
                // Lagt i material för att listile ska kunna ha opacitet, fungerar ej med container
                // Ändrat till 100% transparent för att inte synas
                child: _listView())
          ],
        ));
  }

  Widget _dropDownButton(context) {
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
                    _dropdownMenuItem('All', context),
                    _dropdownMenuItem('Done', context),
                    _dropdownMenuItem('Undone', context)
                  ],
                  onChanged: (String? value) {
                    Provider.of<MainviewNotifier>(context, listen: false)
                        .setDropdownValue = value!;
                  }),
            ));
  }

  DropdownMenuItem<String> _dropdownMenuItem(String value, context) {
    if (value ==
        Provider.of<MainviewNotifier>(context, listen: false)
            .getDropdownValue) {
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

  Widget _listView() {
    return Consumer<MainviewNotifier>(
        builder: (context, mainviewNotifier, child) => ListView.builder(
            itemBuilder: (context, index) =>
                _listTile(mainviewNotifier.getListTasks[index], context),
            itemCount: mainviewNotifier.getListTasks.length));
  }

  Widget _addButtonFirstView(context) {
    return FloatingActionButton(
        onPressed: () {
          Provider.of<MyErrorNotifier>(context, listen: false)
              .setErrorMessage(false);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddView()));
        },
        backgroundColor: appbarColor,
        child: const Icon(
          Icons.add,
          size: 30,
        ));
  }

  Widget _listTile(Task task, context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 4),
      child: ListTile(
        tileColor: boxColor,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        leading: _checkBox(task, context),
        title: _textListTile(task, context),
        trailing: Wrap(
          spacing: 10,
          children: [
            _editButtonMainView(task, context),
            _deleteButton(task, context)
          ],
        ),
      ),
    );
  }

  Widget _checkBox(Task task, context) {
    return Checkbox(
        activeColor: checkboxCheckedColor,
        value: task.getDone,
        onChanged: (bool? valueDone) {
          Provider.of<MainviewNotifier>(context, listen: false)
              .editTask(label: task.getLabel, id: task.getId, done: valueDone);
        });
  }

  Widget _textListTile(Task task, context) {
    if (task.getDone == true) {
      return Text(task.getLabel,
          style: const TextStyle(
              decoration: TextDecoration.lineThrough, color: textColor));
    } else {
      return Text(task.getLabel, style: const TextStyle(color: textColor));
    }
  }

  Widget _editButtonMainView(Task task, context) {
    return IconButton(
        color: iconColor,
        onPressed: () async {
          Provider.of<MyErrorNotifier>(context, listen: false)
              .setErrorMessage(false);
          var newLabel = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditView(task.getLabel)));
          if (newLabel != null) {
            Provider.of<MainviewNotifier>(context, listen: false)
                .editTask(label: newLabel, id: task.getId, done: task.getDone);
          }
        },
        icon: Icon(Icons.edit_outlined));
  }

  Widget _deleteButton(Task task, context) {
    return IconButton(
      color: iconColor,
      icon: const Icon(Icons.delete_outlined),
      onPressed: () {
        Provider.of<MainviewNotifier>(context, listen: false)
            .deleteTask(task.getId);
      },
    );
  }
}
