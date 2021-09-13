import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todos_firebase/components/show_todo_dialog.dart';

class ListTodo extends StatelessWidget {
  ListTodo({
    required this.todoList,
  });

  final QueryDocumentSnapshot todoList;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "${todoList.data()['title']}",
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
      tileColor: Colors.blue,
      trailing: Icon(Icons.arrow_left_outlined, size: 40, color: Colors.white,),
      onTap: () {
        showTodoDialog(context: context, todoList: todoList, type: "Update");
      },
    );
  }
}
