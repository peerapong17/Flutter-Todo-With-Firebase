import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonAdd extends StatelessWidget {
  const ButtonAdd({
    Key key,
    @required this.todoCollection,
    @required this.todoMessage,
  }) : super(key: key);

  final CollectionReference todoCollection;
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
          todoCollection.add(
            {'title': todoMessage.text},
          );
          todoMessage.clear();
          Navigator.pop(context);
        },
        child: Text('Add'),
      ),
    );
  }
}