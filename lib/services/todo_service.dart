import 'package:cloud_firestore/cloud_firestore.dart';

class TodoService {
  static CollectionReference todoCollection =
      FirebaseFirestore.instance.collection('todos');

  static Future<void> createTodo(String value) async {
    await todoCollection.add(
      {'title': value},
    );
  }

  static Future<void> updateTodo(String id, String value) async {
    await todoCollection.doc(id).update(
      {'title': value},
    );
  }

  static Future<void> deleteTodo(String id) async {
    await todoCollection.doc(id).delete();
  }
}
