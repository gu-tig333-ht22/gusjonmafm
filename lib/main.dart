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
    return Scaffold(appBar: appBarMain(), body: checkList(context));
  }
}

Widget checkList(context) {
  return Column(children: [
    Expanded(child: RowTask()),
    Align(
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
        )),
  ]);
}

Widget RowTask() {
  return Consumer<MyChangeNotifier>(
      builder: (context, myChangeNotifier, child) => ListView.builder(
          itemBuilder: (context, index) =>
              listTile(index, context, myChangeNotifier.getListTasks),
          itemCount: myChangeNotifier.getListTasks.length));
}

Widget listTile(index, context, List<Task> list) {
  return Consumer<MyChangeNotifier>(
      builder: (context, myChangeNotifier, child) => ListTile(
          shape: Border(bottom: BorderSide(color: Color(figmaGrey), width: 1)),
          leading: Checkbox(
              value: list[index].getDone,
              onChanged: (bool? valueDone) {
                myChangeNotifier.taskDone(list[index].getId, valueDone);
              }),
          title: text(list[index].getLabel, list[index].getDone),
          trailing: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              myChangeNotifier.deleteListTask = list[index].getId;
            },
          )));
}

Widget text(text, value) {
  if (value == true) {
    return Text(text, style: TextStyle(decoration: TextDecoration.lineThrough));
  } else {
    return Text(text);
  }
}
