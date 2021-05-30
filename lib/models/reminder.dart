class Reminder {
  final int id;
  final String title;
  final DateTime created;
  final DateTime updated;
  final int status;
  final DateTime dateTodo;

  Reminder(
      {this.id,
      this.title,
      this.created,
      this.updated,
      this.status,
      this.dateTodo});
}
