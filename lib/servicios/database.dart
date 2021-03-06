import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_reminder/models/model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference remindersCollection =
      FirebaseFirestore.instance.collection('reminders');

  Future createUserData(int id, String title, DateTime created,
      DateTime updated, int status, DateTime dateTodo) async {
    int acu = 0;
    FirebaseFirestore.instance
        .collection('reminders')
        .doc(this.uid)
        .collection('tareas')
        .get()
        .then((value) => acu + 1);
    return await remindersCollection
        .doc(uid)
        .collection('tareas')
        .doc("tarea_"+ acu.toString()).set({
      'id': acu + 1,
      'title': title,
      'created': created.toString(),
      'updated': updated.toString(),
      'status': status,
      'dateTodo': dateTodo.toString(),
    });
  }

  List<TodoItem> _reminderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return TodoItem(
        id: (doc.data() as Map)['id'] ?? 0,
        title: (doc.data() as Map)['title'].toString() ?? "",
        updated:
            DateTime.parse((doc.data() as Map)['updated']) ?? DateTime.now(),
        created:
            DateTime.parse((doc.data() as Map)['created']) ?? DateTime.now(),
        status: (doc.data() as Map)['status'] ?? 0,
        dateTodo:
            DateTime.parse((doc.data() as Map)['dateTodo']) ?? DateTime.now(),
      );
    }).toList();
  }

  Stream<List<TodoItem>> get reminders {
    return remindersCollection.snapshots().map(_reminderListFromSnapshot);
  }
}
