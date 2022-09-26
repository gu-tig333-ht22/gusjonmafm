import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appbar.dart';
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
        appBar: appBarMain(context),
        body: Stack(
          children: [
            backgroundImage(),
            filterBackgroundImage(),
            Material(
                color: Color.fromARGB(0, 255, 255, 255),
                // Lagt i material för att listile ska kunna ha opacitet, fungerar ej med container
                // Ändrat till 100% transparent för att inte synas
                child:
                    Column(children: [listView(), addButtonFirstView(context)]))
          ],
        ));
  }

  Widget listView() {
    return Expanded(
      child: Consumer<MainviewNotifier>(
          builder: (context, mainviewNotifier, child) => ListView.builder(
              itemBuilder: (context, index) =>
                  listTile(mainviewNotifier.getListTasks[index], context),
              itemCount: mainviewNotifier.getListTasks.length)),
    );
  }

  Widget addButtonFirstView(context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: FloatingActionButton(
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
            )),
      ),
    );
  }

  Widget listTile(Task task, context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 4),
      child: ListTile(
        tileColor: boxColor,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        leading: checkBox(task, context),
        title: textListTile(task, context),
        trailing: Wrap(
          spacing: 10,
          children: [
            editButtonMainView(task, context),
            deleteButton(task, context)
          ],
        ),
      ),
    );
  }

  Widget checkBox(Task task, context) {
    return Checkbox(
        activeColor: checkboxCheckedColor,
        value: task.getDone,
        onChanged: (bool? valueDone) {
          Provider.of<MainviewNotifier>(context, listen: false)
              .editTask(label: task.getLabel, id: task.getId, done: valueDone);
        });
  }

  Widget textListTile(Task task, context) {
    if (task.getDone == true) {
      return Text(task.getLabel,
          style: const TextStyle(
              decoration: TextDecoration.lineThrough, color: textColor));
    } else {
      return Text(task.getLabel, style: const TextStyle(color: textColor));
    }
  }

  Widget editButtonMainView(Task task, context) {
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

  Widget deleteButton(Task task, context) {
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
