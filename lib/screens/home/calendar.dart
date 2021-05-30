import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:good_reminder/models/db_wrapper.dart';
import 'package:good_reminder/utils/utils.dart';
import 'package:good_reminder/models/model.dart' as Model;

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  String titulo = "Good reminder";
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  ValueNotifier<List<Model.TodoItem>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    getTodosAndDones();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  List<Model.TodoItem> todos = [];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario'),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: "es_ES",
            firstDay: DateTime(
                DateTime.now().year - 1, DateTime.now().month, DateTime.now().day),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.

              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
            eventLoader: (day) {
              return _getEventsForDay(day);
            },
          ),
           const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Model.TodoItem>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index].title}'),
                        title: Text('${value[index].title}'),
                      ),
                    );
                  },
                );
              },
            )
          )
        ],
      )
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        // _rangeStart = null; // Important to clean those
        // _rangeEnd = null;
        // _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  List<Model.TodoItem> _getEventsForDay(DateTime day) {
    List<Model.TodoItem> eventsPerDay = [];
    for (int i = 0; i < todos.length; i++) {
      DateTime todoDay = todos[i].dateTodo;
      if (todoDay.year == day.year &&
          todoDay.month == day.month &&
          todoDay.day == day.day) {
        eventsPerDay.add(todos[i]);
      }
    }
    return eventsPerDay;
  }

  void getTodosAndDones() async {
    final _todos = await DBWrapper.sharedInstance.getTodos();
    final _dones = await DBWrapper.sharedInstance.getDones();

    setState(() {
      todos = _todos;
    });
  }
}
