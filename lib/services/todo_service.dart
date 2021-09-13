import 'package:cloud_firestore/cloud_firestore.dart';

class TodoService {
  CollectionReference todoCollection =
      FirebaseFirestore.instance.collection('todos');

  Future<void> updateTodo({required String id, required String value}) async {
    await todoCollection.doc(id).update(
      {'title': value},
    );
  }

  Future<void> createTodo({required String value}) async {
    await todoCollection.add(
      {'title': value},
    );
  }
}
