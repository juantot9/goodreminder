enum TodoStatus { active, done }

class TodoItem {
  int id;
  String title;
  DateTime created;
  DateTime updated;
  int status;

  TodoItem({this.id, this.title, this.created, this.updated, this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'created': created.toString(),
      'updated': updated.toString(),
      'status': status,
    };
  }

  Map<String, dynamic> toMapAutoID() {
    return {
      'title': title,
      'created': created.toString(),
      'updated': updated.toString(),
      'status': TodoStatus.active.index,
    };
  }
}