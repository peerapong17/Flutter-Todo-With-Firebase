import 'package:flutter/material.dart';

presentDialog(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text('Do you want to remove this transaction'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, "false");
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, "true");
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
