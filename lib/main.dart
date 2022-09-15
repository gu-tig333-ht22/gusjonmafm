import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appbar.dart';
import 'addview.dart';
import 'editview.dart';
import 'notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyChangeNotifier()),
        ChangeNotifierProvider(create: (context) => MyErrorNotifier())
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
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Backgroundimage.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
                decoration:
                    BoxDecoration(color: Color.fromARGB(220, 0, 28, 16))),
            Material(
                color: Color.fromRGBO(0, 0, 0, 0),
                child: Column(children: [
                  rowTasks(),
                  Container(child: addButtonFirstView(context))
                ]))
          ],
        ));
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
            width: 50,
            height: 50,
            child: FloatingActionButton(
                onPressed: () {
                  Provider.of<MyErrorNotifier>(context, listen: false)
                      .setErrorMessage(false);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddView()));
                },
                backgroundColor: Color.fromARGB(100, 255, 255, 255),
                child: const Icon(
                  Icons.add,
                  size: 30,
                )),
          ),
        ));
  }

  Widget listTile(Task task, context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 4),
      child: ListTile(
        tileColor: Color.fromARGB(80, 255, 255, 255),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
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
        activeColor: Color.fromARGB(100, 0, 28, 18),
        value: task.getDone,
        onChanged: (bool? valueDone) {
          Provider.of<MyChangeNotifier>(context, listen: false)
              .editTask(label: task.getLabel, id: task.getId, done: valueDone);
        });
  }

  Widget textListTile(Task task, context) {
    if (task.getDone == true) {
      return Text(task.getLabel,
          style: const TextStyle(
              decoration: TextDecoration.lineThrough, color: Colors.white));
    } else {
      return Text(task.getLabel, style: const TextStyle(color: Colors.white));
    }
  }

  Widget editButtonMainView(Task task, context) {
    return IconButton(
        onPressed: () async {
          Provider.of<MyErrorNotifier>(context, listen: false)
              .setErrorMessage(false);
          var newLabel = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditView(task.getLabel)));
          if (newLabel != null) {
            Provider.of<MyChangeNotifier>(context, listen: false)
                .editTask(label: newLabel, id: task.getId, done: task.getDone);
          }
        },
        icon: Icon(Icons.edit_outlined));
  }

  Widget deleteButton(Task task, context) {
    return IconButton(
      icon: const Icon(Icons.delete_outlined),
      onPressed: () {
        Provider.of<MyChangeNotifier>(context, listen: false)
            .deleteTask(task.getId);
      },
    );
  }
}
