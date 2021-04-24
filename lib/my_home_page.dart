import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'concerning_to_list/button_add.dart';
import 'concerning_to_list/list_todo.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController todoMessage = TextEditingController();
  TextEditingController todoAddMessage = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  CollectionReference todoCollection =
      FirebaseFirestore.instance.collection('todos');

  Future<Null> refreshList() async {
    await Future.delayed(
      Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: refreshList,
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  "TODO LIST",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Divider(),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("todos")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var todoList = snapshot.data.docs[index];
                          TextEditingController todoUpdate =
                              TextEditingController(
                                  text: todoList.data()['title']);
                          return Dismissible(
                            direction: DismissDirection.horizontal,
                            key: UniqueKey(),
                            background: Container(
                              padding: EdgeInsets.only(left: 20),
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.delete),
                              color: Colors.red,
                            ),
                            onDismissed: (direction) {
                              todoCollection.doc(todoList.id).delete();
                            },
                            child: ListTodo(
                                todoList: todoList,
                                todoUpdate: todoUpdate,
                                todoCollection: todoCollection,
                                todoMessage: todoMessage),
                          );
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Row(
                  children: [
                    Text('Add Todo'),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                children: [
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      controller: todoMessage,
                      autofocus: true,
                      decoration: InputDecoration(hintText: "eg. Work Out"),
                    ),
                  ),
                  ButtonAdd(
                      todoCollection: todoCollection, todoMessage: todoMessage),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
