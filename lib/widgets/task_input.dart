import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class TaskInput extends StatefulWidget {
  final Function onSubmitted;

  TaskInput({@required this.onSubmitted});

  @override
  _TaskInputState createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController dateEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 5),
              width: 40,
              child: Icon(
                Icons.add,
                color: Color(0xffca3e47),
                size: 30,
              ),
            ),
            Expanded(
              child: TextField(
                minLines: 1,
                maxLines: 2,
                decoration: InputDecoration(
                    hintText: '¿Qué quieres hacer?',
                    border: InputBorder.none),
                textInputAction: TextInputAction.done,
                controller: textEditingController,
                /*onEditingComplete: () {
                  widget.onSubmitted(controller: textEditingController);
                  widget.onSubmitted(controller: dateEditingController);
                },*/
              ),
            ),
            Expanded(
              child: DateTimeField(
                selectedDate: selectedDate,
                mode:DateTimeFieldPickerMode.date,
                decoration: InputDecoration(
                    hintText: '¿Y cuándo?',
                    border: InputBorder.none),
                onDateSelected: (DateTime value) {
                  widget.onSubmitted(value, controller: textEditingController);
                  // widget.onSubmitted(controller: dateEditingController);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  DateTime selectedDate = DateTime.now();
}