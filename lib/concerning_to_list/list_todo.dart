import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'button_update.dart';

class ListTodo extends StatelessWidget {
  const ListTodo({
    Key key,
    @required this.todoList,
    @required this.todoUpdate,
    @required this.todoCollection,
    @required this.todoMessage,
  }) : super(key: key);

  final QueryDocumentSnapshot todoList;
  final TextEditingController todoUpdate;
  final CollectionReference todoCollection;
  final TextEditingController todoMessage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${todoList.data()['title']}',
        style: TextStyle(color: Colors.white),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
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
                    controller: todoUpdate,
                    enableSuggestions: true,
                    autofocus: true,
                    decoration: InputDecoration(hintText: "eg. Work Out"),
                  ),
                ),
                ButtonUpdate(
                    todoCollection: todoCollection,
                    todoList: todoList,
                    todoUpdate: todoUpdate,
                    todoMessage: todoMessage),
              ],
            );
          },
        );
      },
    );
  }
}