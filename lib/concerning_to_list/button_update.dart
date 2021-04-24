import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonUpdate extends StatelessWidget {
  const ButtonUpdate({
    Key key,
    @required this.todoCollection,
    @required this.todoList,
    @required this.todoUpdate,
    @required this.todoMessage,
  }) : super(key: key);

  final CollectionReference todoCollection;
  final QueryDocumentSnapshot todoList;
  final TextEditingController todoUpdate;
  final TextEditingController todoMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          todoCollection.doc(todoList.id).update(
            {'title': todoUpdate.text},
          );
          todoMessage.clear();
          Navigator.pop(context);
        },
        child: Text('Update'),
      ),
    );
  }
}