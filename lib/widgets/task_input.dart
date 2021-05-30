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
              margin: EdgeInsets.only(top: 9),
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
                    hintText: '¿Qué vas a hacer?',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    border: InputBorder.none),
                textInputAction: TextInputAction.done,
                controller: textEditingController,
                onEditingComplete: () {
                  widget.onSubmitted(controller: textEditingController, dateValue: DateTime.now());
                },
              ),
            ),
            Expanded(
              child: DateTimeField(
                mode: DateTimeFieldPickerMode.date,
                decoration: InputDecoration(
                  hintText: 'Seleccionar fecha',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.cyan[700]),
                  border: InputBorder.none,
                ),
                onDateSelected: (DateTime value) {
                  widget.onSubmitted(controller: textEditingController, dateValue: value);
                },
                selectedDate: null,
                // onSaved: ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
