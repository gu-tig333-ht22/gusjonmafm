import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appbar.dart';
import 'secondview.dart';
import 'notifier.dart';

const int figmaGrey = 0xffC4C4C4;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyChangeNotifier())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainView(),
          theme: ThemeData(fontFamily: 'RobotoRegular')),
    );
  }
}

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        body: Column(children: [
          rowTasks(),
          addButtonFirstView(context),
        ]));
  }

  Widget rowTasks() {
    return Expanded(
      child: Consumer<MyChangeNotifier>(
          builder: (context, myChangeNotifier, child) => ListView.builder(
              itemBuilder: (context, index) =>
                  listTile(myChangeNotifier.getListTasks[index], context),
              itemCount: myChangeNotifier.getListTasks.length)),
    );
  }

  Widget addButtonFirstView(context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: SizedBox(
            width: 56,
            height: 56,
            child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SecondView()));
                },
                backgroundColor: Color(figmaGrey),
                child: Icon(
                  Icons.add,
                  size: 56,
                )),
          ),
        ));
  }

  Widget listTile(Task task, context) {
    return ListTile(
        shape: Border(bottom: BorderSide(color: Color(figmaGrey), width: 1)),
        leading: checkBox(task, context),
        title: textListTile(task, context),
        trailing: deleteButton(task, context));
  }

  Widget checkBox(Task task, context) {
    return Checkbox(
        value: task.getDone,
        onChanged: (bool? valueDone) {
          Provider.of<MyChangeNotifier>(context, listen: false)
              .changeTaskDone(task.getId, valueDone);
        });
  }

  Widget deleteButton(Task task, context) {
    return IconButton(
      icon: Icon(Icons.close),
      onPressed: () {
        Provider.of<MyChangeNotifier>(context, listen: false).deleteTask =
            task.getId;
      },
    );
  }

  Widget textListTile(Task task, context) {
    if (task.getDone == true) {
      return Text(task.getLabel,
          style: TextStyle(decoration: TextDecoration.lineThrough));
    } else {
      return Text(task.getLabel);
    }
  }
}
