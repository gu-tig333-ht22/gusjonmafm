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

  set _setLabel(String label) {
    this._label = label;
  }

  set _setDone(bool? done) {
    this._done = done;
  }

  set _setId(int id) {
    this._id = id;
  }
}

class MyChangeNotifier extends ChangeNotifier {
  final List<String> _dropdownValueList = ['All', 'Done', 'Undone'];
  late String _dropdownValue = _dropdownValueList.first;

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

  late List<Task> newList = [];

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

  set deleteTask(int id) {
    _listTasks.remove(_listTasks.firstWhere((task) => task._id == id));
    notifyListeners();
  }

  void changeTaskDone(int id, bool? valueDone) {
    _listTasks.firstWhere((task) => task._id == id)._setDone = valueDone;
    notifyListeners();
  }

  void addTask(String label, {int? id}) {
    if (id == null) {
      id = globalId;
    }
    _listTasks.add(Task(label, id));
    globalId += 1;
    notifyListeners();
  }

  void editTask(String label, int id) {
    _listTasks.firstWhere((task) => task._id == id)._setLabel = label;
    notifyListeners();
  }
}

class MyErrorNotifier extends ChangeNotifier {
  String _errorMessage = "";

  get getErrorMessage => _errorMessage;

  void setErrorMessage(bool bool) {
    if (bool == true) {
      _errorMessage = 'Must contain at least one character';
    } else {
      _errorMessage = '';
    }
    notifyListeners();
  }
}
