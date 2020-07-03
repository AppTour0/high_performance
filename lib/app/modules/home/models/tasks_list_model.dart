class TasksListModel {
  int id = 0;
  int idTask = 0;
  String dateModification = "";

  TasksListModel({this.id, this.idTask, this.dateModification});

  factory TasksListModel.fromMap(Map<String, dynamic> json) {
    return TasksListModel(
      id: json["id"],
      idTask: json["id_task"],
      dateModification: json["date_modification"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_task': idTask,
      'date_modification': dateModification,
    };
  }

  /* factory TasksListModel.fromJson(Map<String, dynamic> json) {
    return TasksListModel(
        //field: json[''],
        );
  }

  Map<String, dynamic> toJson(TasksListModel model) {
    Map<String, dynamic> json = Map<String, dynamic>();

    return json;
  } */
}
