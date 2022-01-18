import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      accentColor: Colors.orange
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List todo = [];

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
      appBar: AppBar(title: Text("ToDo List"),
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

