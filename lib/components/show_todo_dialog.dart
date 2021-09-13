import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todos_firebase/services/todo_service.dart';

Future<dynamic> showTodoDialog({
  required BuildContext context,
  required String type,
  QueryDocumentSnapshot? todoList,
}) {
  TodoService todoService = new TodoService();
  TextEditingController todoUpdateInput = new TextEditingController(
      text: todoList != null ? todoList.data()['title'] : '');
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Text('$type Todo'),
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
              controller: todoUpdateInput,
              enableSuggestions: true,
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
              onPressed: () async {
                if (type == "Update") {
                  await todoService.updateTodo(
                      id: todoList!.id, value: todoUpdateInput.text);
                } else {
                  await todoService.createTodo(value: todoUpdateInput.text);
                }
                Navigator.pop(context);
              },
              child: Text(type),
            ),
          ),
        ],
      );
    },
  );
}
