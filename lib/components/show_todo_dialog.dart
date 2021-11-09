import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todos_firebase/services/todo_service.dart';

Future<dynamic> showTodoDialog(BuildContext context,
    [QueryDocumentSnapshot? todoList]) {
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
            Text(todoList != null ? 'Update Todo' : 'Create Todo'),
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
              //cause populate twice
              // autofocus: true,
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
                if (todoList != null) {
                  await TodoService.updateTodo(
                    todoList.id,
                    todoUpdateInput.text,
                  );
                } else {
                  await TodoService.createTodo(todoUpdateInput.text);
                }
                Navigator.pop(context);
              },
              child: Text(todoList != null ? "Update" : "Create"),
            ),
          ),
        ],
      );
    },
  );
}
