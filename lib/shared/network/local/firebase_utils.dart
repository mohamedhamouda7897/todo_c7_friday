import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/task.dart';

CollectionReference<Task> getTaskCollection() {
  return FirebaseFirestore.instance.collection('tasks').withConverter<Task>(
        fromFirestore: (snapshot, options) => Task.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}

Future<void> addTaskToFireStore(Task task) {
  var collection = getTaskCollection();
  var docRef = collection.doc();
  task.id = docRef.id;
  return docRef.set(task);
}

Stream<QuerySnapshot<Task>> getTasksFromFirestore(DateTime dateTime) {
  print('hint ${dateTime}');

  return getTaskCollection()
      .where('date',
          isEqualTo: DateUtils.dateOnly(dateTime).microsecondsSinceEpoch)
      .snapshots();
}

Future<void> deleteTaskFromFirestore(String id) {
  return getTaskCollection().doc(id).delete();
}
