class TasksModel {
  int id = 0;
  String name = "";
  String dateModification = "";

  TasksModel({this.id, this.name, this.dateModification});

  factory TasksModel.fromMap(Map<String, dynamic> json) {
    return TasksModel(
      id: json["id"],
      name: json["name"],
      dateModification: json["date_modification"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date_modification': dateModification,
    };
  }

  /* factory TasksModel.fromJson(Map<String, dynamic> json) {
    return TasksModel(
        //field: json[''],
        );
  }

  Map<String, dynamic> toJson(TasksModel model) {
    Map<String, dynamic> json = Map<String, dynamic>();

    return json;
  } */
}
