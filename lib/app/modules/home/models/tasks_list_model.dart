class TasksListModel {
  int id = 0;
  int idTask = 0;
  String dateCreate = "";
  String name;

  TasksListModel({this.id, this.idTask, this.dateCreate, this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task_id': idTask,
      'date_create': dateCreate,
      'name': name,
    };
  }
}
