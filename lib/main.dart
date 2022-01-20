import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      accentColor: Colors.orange
    ),
    home: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List todo = [];
  String input = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todo.add("item1");
    todo.add("item2");
    todo.add("item3");
    todo.add("item4");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ToDoList App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: const Text("Add todolist"),
                  content: TextField(
                    onChanged: (String value){
                      input = value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(onPressed: () {
                      setState(() {
                        todo.add(input);
                      });
                    }, child: const Text("Add"))
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(itemCount: todo.length,
          itemBuilder: (BuildContext context, int index){
        return Dismissible(key: Key(todo[index]), child: Card(
          child: ListTile(
            title: Text(todo[index]),
          ),
        ));
      }),
    );
  }
}

