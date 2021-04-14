import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                          TextEditingController todoUpdate =
                              TextEditingController(
                                  text: snapshot.data.docs[index]
                                      .data()['title']);
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
                              todoCollection
                                  .doc(snapshot.data.docs[index].id)
                                  .delete();
                            },
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SimpleDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      title: Row(
                                        children: [
                                          Text('Update Todo'),
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
                                          padding: EdgeInsets.all(10),
                                          child: TextFormField(
                                            controller: todoUpdate,enableSuggestions: true,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                                hintText: "eg. Work Out"),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty
                                                    .all<OutlinedBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                    side: BorderSide(
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                todoCollection
                                                    .doc(snapshot
                                                        .data.docs[index].id)
                                                    .update(
                                                  {'title': todoUpdate.text},
                                                );
                                                todoMessage.clear();
                                                Navigator.pop(context);
                                              },
                                              child: Text('Update')),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              title: Text(
                                '${snapshot.data.docs[index].data()['title']}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
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
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: todoMessage,
                      autofocus: true,
                      decoration: InputDecoration(hintText: "eg. Work Out"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                        onPressed: () {
                          todoCollection.add(
                            {'title': todoMessage.text},
                          );
                          todoMessage.clear();
                          Navigator.pop(context);
                        },
                        child: Text('Add')),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
