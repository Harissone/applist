import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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

  createtodo(){

  }

  deletetodo(){

  }

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
      //appBar: AppBar(title: const Text("ToDoList App"),
      //),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                      Navigator.of(context).pop();
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
          elevation: 4,
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            title: Text(todo[index]),
            trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red,),
              onPressed: (){
                setState(() {
                  todo.removeAt(index);
                });
              }),
          ),
        ));
      }),
    );
  }
}

