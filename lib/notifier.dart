import 'package:flutter/material.dart';

class Task {
  late String _label;
  late int _id;
  bool? _done = false;

  Task(String label, int id) {
    this._label = label;
    this._id = id;
  }
  get getLabel => _label;
  get getDone => _done;
  get getId => _id;

  set setLabel(String label) {
    this._label = label;
  }

  set setDone(bool? done) {
    this._done = done;
  }

  set setId(int id) {
    this._id = id;
  }
}

class MyChangeNotifier extends ChangeNotifier {
  final List<String> _dropdownValueList = ['All', 'Done', 'Undone'];
  late String _dropdownValue = _dropdownValueList.first;
  late List<Task> newList = [];
  int globalId = 6;

  late List<Task> _listTasks = [
    Task('Write a book', 1),
    Task('Take a nap', 2),
    Task('Eat', 3),
    Task('Do homework', 4),
    Task('Eat again', 5)
  ];

  List<String> get getDropdownValueList => _dropdownValueList;
  String get getDropdownValue => _dropdownValue;

  get getListTasks {
    if (_dropdownValue == 'All') {
      newList = _listTasks;
      return newList;
    } else if (_dropdownValue == 'Done') {
      newList = _listTasks.where((task) => task._done == true).toList();
      return newList;
    } else if (_dropdownValue == 'Undone') {
      newList = _listTasks.where((task) => task._done == false).toList();
      return newList;
    }
  }

  set setDropdownValue(String valueDropdown) {
    _dropdownValue = valueDropdown;
    notifyListeners();
  }

  set deleteListTask(int id) {
    _listTasks.remove(_listTasks.firstWhere((task) => task._id == id));
    notifyListeners();
  }

  set addListTasks(Task task) {
    _listTasks.add(task);
    notifyListeners();
  }

  taskDone(int id, bool? valueDone) {
    _listTasks.firstWhere((task) => task._id == id).setDone = valueDone;
    notifyListeners();
  }

  int getTaskId(Task task) {
    return identityHashCode(task);
  }

  addTask(String label, {int? id}) {
    if (id == null) {
      id = globalId;
    }
    _listTasks.add(Task(label, id));
    globalId += 1;
    notifyListeners();
  }
}
