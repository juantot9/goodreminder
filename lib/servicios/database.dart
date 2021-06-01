import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_reminder/models/model.dart';
import 'package:good_reminder/models/reminder.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference remindersCollection =
      FirebaseFirestore.instance.collection('reminders');

  Future updateUserData(int id, String title, DateTime created,
      DateTime updated, int status, DateTime dateTodo) async {
    return await remindersCollection.doc(uid).set({
      'id': id,
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
        title: (doc.data()  as Map)['title'].toString() ?? "",
        updated: DateTime.parse((doc.data() as Map)['updated']) ?? DateTime.now(),
        created: DateTime.parse((doc.data() as Map)['created']) ?? DateTime.now(),
        status: (doc.data() as Map)['status'] ?? 0,
        dateTodo: DateTime.parse((doc.data() as Map)['dateTodo']) ?? DateTime.now(),
      );
    }).toList();
  }

  Stream<List<TodoItem>> get reminders {
    return remindersCollection
        .snapshots()
        .map(_reminderListFromSnapshot);
  }
}
