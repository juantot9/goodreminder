import 'package:cloud_firestore/cloud_firestore.dart';
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

  List<Reminder> _reminderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Reminder(
        id: (doc.data() as Map)['id'] ?? null,
        title: (doc.data()  as Map)['title'] ?? null,
        updated: (doc.data() as Map)['updated'] ?? null,
        status: (doc.data() as Map)['status'] ?? null,
        dateTodo: (doc.data() as Map)['dateTodo'] ?? null,
      );
    }).toList();
  }

  Stream<List<Reminder>> get reminders {
    return remindersCollection
        .snapshots()
        .map(_reminderListFromSnapshot);
  }
}
