import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class Task {
  final String _label;
  final String _id;
  final bool? _done;

  Task(this._label, this._id, this._done);

  get getLabel => _label;
  get getId => _id;
  get getDone => _done;
}

class MyChangeNotifier extends ChangeNotifier {
  final List<String> _dropdownValueList = ['All', 'Done', 'Undone'];
  late String _dropdownValue = _dropdownValueList.first;
  late List<Task> filteredList;

  String homepage = "https://todoapp-api.apps.k8s.gu.se/todos";
  String key = "?key=ec7ee6eb-8436-4e20-8375-0434bfdcd0ba";
  final List<Task> _listTasks = [];

  MyChangeNotifier() {
    getInitTaskList();
  }

  List<String> get getDropdownValueList => _dropdownValueList;
  String get getDropdownValue => _dropdownValue;

  void getInitTaskList() async {
    http.Response answer = await http.get(Uri.parse('$homepage$key'));
    var listJsonObject = jsonDecode(answer.body);
    updateListTasks(listJsonObject);
  }

  void updateListTasks(listJsonObject) {
    _listTasks.clear();
    listJsonObject.forEach((object) {
      _listTasks.add(Task(object["title"], object["id"], object["done"]));
    });
    notifyListeners();
  }

  get getListTasks {
    if (_dropdownValue == 'All') {
      filteredList = _listTasks;
      return filteredList;
    } else if (_dropdownValue == 'Done') {
      filteredList = _listTasks.where((task) => task._done == true).toList();
      return filteredList;
    } else if (_dropdownValue == 'Undone') {
      filteredList = _listTasks.where((task) => task._done == false).toList();
      return filteredList;
    }
  }

  set setDropdownValue(String valueDropdown) {
    _dropdownValue = valueDropdown;
    notifyListeners();
  }

  void deleteTask(String id) async {
    http.Response answer = await http.delete(Uri.parse('$homepage/$id$key'));
    var listJsonObject = jsonDecode(answer.body);
    updateListTasks(listJsonObject);
  }

  void addTask(String label) async {
    http.Response answer = await http.post(Uri.parse('$homepage$key'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"title": label}));
    var listJsonObject = jsonDecode(answer.body);
    updateListTasks(listJsonObject);
  }

  void editTask(
      {required String label, required String id, required bool? done}) async {
    http.Response answer = await http.put(Uri.parse('$homepage/$id$key'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"title": label, "done": done}));
    var listJsonObject = jsonDecode(answer.body);
    updateListTasks(listJsonObject);
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
