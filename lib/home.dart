import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todos_firebase/components/present_alert.dart';
import 'package:todos_firebase/components/show_todo_dialog.dart';
import 'package:todos_firebase/services/todo_service.dart';

import 'components/todo_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  initState() {
    print("initState run");
  }

  @override
  didChangeDependencies() {
    print("didChangeDependencies run");
  }

  Future<Null> refreshList() async {
    await Future.delayed(
      Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("build method run");
    return Scaffold(
      backgroundColor: Colors.grey,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showTodoDialog(context),
      ),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: refreshList,
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  "DAILY TODO",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.white,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("todos")
                      .snapshots(),
                  builder: (context, snapshot) {
                    print("snaptshot change");
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          QueryDocumentSnapshot todoList =
                              snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Dismissible(
                              direction: DismissDirection.horizontal,
                              key: UniqueKey(),
                              background: Container(
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.centerLeft,
                                child: Icon(Icons.delete),
                                color: Colors.red,
                              ),
                              onDismissed: (direction) {
                                TodoService.deleteTodo(todoList.id);
                              },
                              confirmDismiss: (direction) async {
                                final value = await presentDialog(context);
                                if (value == "true") {
                                  return true;
                                } else {
                                  return false;
                                }
                              },
                              child: ListTodo(todoList: todoList),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("There was an error");
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
