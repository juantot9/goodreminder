import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

final String uid;
DatabaseService({this.uid});

final CollectionReference remindersCollection = FirebaseFirestore.instance.collection('reminders');

Future updateUserData(int id, String titulo, DateTime created, DateTime updated, int status, DateTime dateTodo) async {

return await remindersCollection.doc(uid).set({
  'id': id,
  'titulo': titulo,
  'created': created,
  'updated': updated,
  'status': status,
  'dateTodo': dateTodo
});

}

// int id;
//   String title;
//   DateTime created;
//   DateTime updated;
//   int status;
//   DateTime dateTodo;


}