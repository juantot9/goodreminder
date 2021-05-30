import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

final String uid;
DatabaseService({this.uid});

final CollectionReference remindersCollection = FirebaseFirestore.instance.collection('reminders');

Future updateUserData(int id, String titulo, DateTime created, DateTime updated, int status, DateTime dateTodo) async {

//return await remindersCollection.

}

// int id;
//   String title;
//   DateTime created;
//   DateTime updated;
//   int status;
//   DateTime dateTodo;


}