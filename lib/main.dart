import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'appbar.dart';
import 'secondview.dart';

const int figmaGrey = 0xffC4C4C4;
List<Task> listTasks = [
  Task(label: 'Write a book'),
  Task(label: 'Do homework'),
  Task(label: 'Do homework'),
  Task(label: 'Do homework'),
  Task(label: 'Write a book'),
  Task(label: 'Do homework'),
  Task(label: 'Do homework'),
  Task(label: 'Do homework'),
  Task(label: 'Write a book'),
  Task(label: 'Do homework'),
  Task(label: 'Do homework'),
  Task(label: 'Do homework'),
  Task(label: 'Write a book'),
  Task(label: 'Do homework'),
  Task(label: 'Do homework'),
  Task(label: 'Do homework'),
  Task(label: 'Do homework')
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainView(),
        theme: ThemeData(fontFamily: 'RobotoRegular'));
  }
}

class Task {
  late String _label;
  late int? _index;
  bool _done = false;

  Task({required String label}) {
    this._label = label;
  }

  get label {
    return _label;
  }

  get done {
    return _done;
  }

  get index {
    return _index;
  }

  set label(label) {
    this._label = label;
  }

  set done(done) {
    this._done = done;
  }

  set index(index) {
    this._index = index;
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

class RowTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RowTaskState();
  }
}

class RowTaskState extends State<RowTask> {
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) => listTile(index),
        itemCount: listTasks.length);
  }

  Widget listTile(index) {
    return ListTile(
        shape: Border(bottom: BorderSide(color: Color(figmaGrey), width: 1)),
        leading: Checkbox(
            value: listTasks[index].done,
            onChanged: (bool? value) {
              setState(() {
                listTasks[index].done = value;
              });
            }),
        title: text(index),
        trailing: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            setState(() {
              listTasks.removeAt(index);
            });
          },
        ));
  }

  Widget text(index) {
    if (listTasks[index].done == true) {
      return Text(listTasks[index].label,
          style: TextStyle(decoration: TextDecoration.lineThrough));
    } else {
      return Text(listTasks[index].label);
    }
  }
}
