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
    //TODO reminders.forEach((reminder) { print(reminder.id) });


    return Container(
      
    );
  }
}