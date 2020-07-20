class TasksModel {
  int id = 0;
  String name = "";
  String dateModification;
  String dateCreate;

  TasksModel({this.id, this.name, this.dateModification, this.dateCreate});

  factory TasksModel.fromMap(Map<String, dynamic> json) {
    return TasksModel(
      id: json["id"],
      name: json["name"],
      dateModification: json["date_modification"],
      dateCreate: json["date_create"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date_modification': dateModification,
      'date_create': dateCreate,
    };
  }
}
