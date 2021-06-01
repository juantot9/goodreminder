import 'package:flutter/material.dart';
import 'package:good_reminder/models/reminder.dart';
import 'package:provider/provider.dart';

class ReminderList extends StatefulWidget {
  @override
  _ReminderListState createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  @override
  Widget build(BuildContext context) {
    final reminders = Provider.of<List<Reminder>>(context);

    reminders.forEach((reminder) {
      print(reminder.id);
      print(reminder.title);
      print(reminder.created);
      print(reminder.updated);
      print(reminder.status);
      print(reminder.dateTodo);
    });

    // for (var doc in brews.documents) {
    //   print(doc.data);
    // }

    return Container();
  }
}
