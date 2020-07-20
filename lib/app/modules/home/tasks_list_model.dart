class TasksListModel {
  int id = 0;
  int idTask = 0;
  String dateCreate;
  String name; // inner join table tasks
  bool alarm;
  bool mon;
  bool tue;
  bool wed;
  bool thu;
  bool fri;
  bool sat;
  bool sun;
  int amount;
  String time;
  String description;
  String dateModification;

  TasksListModel(
      {this.id,
      this.idTask,
      this.dateCreate,
      this.name,
      this.alarm,
      this.mon,
      this.tue,
      this.wed,
      this.thu,
      this.fri,
      this.sat,
      this.sun,
      this.amount,
      this.time,
      this.description,
      this.dateModification});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task_id': idTask,
      'date_create': dateCreate,
      'name': name,
      'alarm': alarm,
      'mon': mon,
      'tue': tue,
      'wed': wed,
      'thu': thu,
      'fri': fri,
      'sat': sat,
      'sun': sun,
      'amount': amount,
      'time': time,
      'description': description,
      'date_modification': dateModification
    };
  }
}
