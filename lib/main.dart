import 'package:flutter/foundation.dart';
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

  createTodo(){
    DocumentReference documentReference = FirebaseFirestore.instance.collection("MyTodo").doc(input);
    //Map
    Map<String, String> todo = {"todoTitle": input};
    documentReference.set(todo).whenComplete(() {
      if (kDebugMode) {
        print("$input created");
      }
    });
  }

  deleteTodo(item){
    DocumentReference documentReference = FirebaseFirestore.instance.collection("MyTodo").doc(item);

    documentReference.delete().whenComplete(() {
      if (kDebugMode) {
        print("$item Deleted");
      }
    });
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
                      //createtodo for add input in FirebaseFirestore.
                      createTodo();

                      //setState for add input to list collection.
                      /*setState(() {
                        todo.add(input);
                      });*/

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

      body: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection("MyTodo").snapshots(), builder: (context, snapshots){
        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshots.data!.docs.length,
            itemBuilder: (context, index){
              if (snapshots.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                const Center(
                  child: Icon(
                    Icons.signal_wifi_connected_no_internet_4_outlined,
                    color: Colors.blue,
                  ),
                );

              } //facing error

              DocumentSnapshot documentSnapshot = snapshots.data!.docs[index];
              return Dismissible(key: Key(index.toString()), child: Card(
                elevation: 4,
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  title: Text(documentSnapshot["todoTitle"]),
                  trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red,),
                      onPressed: (){
                        deleteTodo(documentSnapshot["todoTitle"]);
                      //setState to delete input on list collection
                        /*setState(() {
                          todo.removeAt(index);
                        });*/
                      }),
                ),
              ));
            });
      })

            //Retrieve data from list collection to ListView
            /*ListView.builder(itemCount: todo.length,
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
      }),*/

    );
  }
}

