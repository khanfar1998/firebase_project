//firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/tasks/models/task_model.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTask(TaskModel task) async {
    await _firestore.collection('tasks').add(task.toMap());
  }

  Future<void> updateTask(String id, TaskModel task) async {
    await _firestore.collection('tasks').doc(id).update(task.toMap());
  }

  Future<void> deleteTask(String id) async {
    await _firestore.collection('tasks').doc(id).delete();
  }

  Stream<List<TaskModel>> getTasks(String userId) {
    return _firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) =>
                    TaskModel.fromJson(doc.data() as Map<String, dynamic>)
                      ..id = doc.id,
              )
              .toList(),
        );
  }
}
