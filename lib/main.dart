import 'dart:html';

import 'package:flutter/material.dart';

const int figmaGrey = 0xffC4C4C4;
const List<String> list = <String>['All', 'Done', 'Undone'];

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

PreferredSize _appBarMain() {
  return PreferredSize(
    preferredSize: Size.fromHeight(48),
    child: AppBar(
      centerTitle: true,
      title: const Text(
        'TIG333 TODO',
        style: TextStyle(fontSize: 26, color: Colors.black),
      ),
      backgroundColor: Color(figmaGrey),
      actions: [DropdownButtonExample()],
    ),
  );
}

PreferredSize _appBarSecond() {
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

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarMain(),
      body: _checkList(context),
    );
  }

  Widget _checkList(context) {
    return Column(children: [
      Expanded(
          child: ListView.builder(
              itemBuilder: (context, index) => _row(_list()[index]),
              itemCount: _list().length)),
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
          ))
    ]);
  }

  List _list() {
    return [
      'Write a book',
      'Do homework',
      'Tidy room',
      'Watch TV',
      'Roboto font test'
    ];
  }

  Widget _row(text) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(figmaGrey)))),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Checkbox(value: false, onChanged: (bool? value) {}),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 22, top: 20, bottom: 20),
              child: Text(
                text,
                //style: TextStyle(fontFamily: ''),
              )),
          Expanded(
              child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 18),
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {},
                    ),
                  ))),
        ],
      ),
    );
  }
}

class SecondView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarSecond(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 40),
              child: _textField(context),
            ),
            _addButton()
          ],
        ),
      ),
    );
  }

  Widget _addButton() {
    return TextButton.icon(
      // <-- TextButton
      onPressed: () {},
      style: TextButton.styleFrom(primary: Colors.black),
      icon: Icon(
        Icons.add,
        size: 25.0,
      ),
      label: Text('Add', style: TextStyle(fontSize: 16)),
    );
  }

  Widget _textField(context) {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width *
            351 /
            411, // Satt boxen till samma proportioner som i figma
        decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: TextField());
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      style: const TextStyle(color: Colors.black),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
