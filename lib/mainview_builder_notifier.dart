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

class MainviewNotifier extends ChangeNotifier {
  late String _dropdownValue = 'All';
  final List<Task> _listTasks = [];

  String homepage = "https://todoapp-api.apps.k8s.gu.se/todos";
  String key = "?key=ec7ee6eb-8436-4e20-8375-0434bfdcd0ba";

  MainviewNotifier() {
    getInitTaskList();
  }

  String get getDropdownValue => _dropdownValue;

  get getListTasks {
    if (_dropdownValue == 'All') {
      return _listTasks;
    } else if (_dropdownValue == 'Done') {
      return _listTasks.where((task) => task._done == true).toList();
    } else if (_dropdownValue == 'Undone') {
      return _listTasks.where((task) => task._done == false).toList();
    }
  }

  set setDropdownValue(String valueDropdown) {
    _dropdownValue = valueDropdown;
    notifyListeners();
  }

  void updateListTasks(listJsonObject) {
    _listTasks.clear();
    listJsonObject.forEach((object) {
      _listTasks.add(Task(object["title"], object["id"], object["done"]));
    });
    notifyListeners();
  }

  void getInitTaskList() async {
    http.Response answer = await http.get(Uri.parse('$homepage$key'));
    var listJsonObject = jsonDecode(answer.body);
    updateListTasks(listJsonObject);
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
