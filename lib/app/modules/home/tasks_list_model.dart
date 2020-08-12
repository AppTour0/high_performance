// To parse this JSON data, do
//
//      cards = cardsFromJson(jsonString);

import 'dart:convert';

/* TasksListModel tasksListFromJson(String str) =>
    TasksListModel.fromJson(json.decode(str));

String tasksListToJson(TasksListModel data) => json.encode(data.toJson()); */

class TasksListModel {
  int id;
  String name;
  bool alarm;
  bool mon;
  bool tue;
  bool wed;
  bool thu;
  bool fri;
  bool sat;
  bool sun;
  bool repeat;
  String message;
  DateTime dateTimeNotification;
  DateTime dateCreate;
  DateTime dateModify;
  String color;
  dynamic taskDetail;
  TasksListModel(
      {this.id,
      this.name,
      this.alarm,
      this.mon,
      this.tue,
      this.wed,
      this.thu,
      this.fri,
      this.sat,
      this.sun,
      this.repeat,
      this.message,
      this.dateTimeNotification,
      this.dateCreate,
      this.dateModify,
      this.color,
      this.taskDetail});

  /* factory TasksListModel.fromJson(Map<String, dynamic> json) => TasksListModel(
      cardholderIdNumber: json["cardholder_id_number"],
      cardholderIdType: json["cardholder_id_type"],
      cardholderName: json["cardholder_name"],
      clientId: json["client_id"],
      customerId: json["customer_id"],
      dateCreated: json['date_created'] != null
          ? DateTime.parse(json['date_created'])
          : null,
      dateLastUpdated: json['date_last_updated'] != null
          ? DateTime.parse(json['date_last_updated'])
          : null,
      firstSixDigits: json["first_six_digits"],
      id: json["id"],
      idCard: json["id_card"],
      lastFourDigits: json["last_four_digits"],
      defaultCard: json["default_card"],
      brand: json["brand"],
      country: json["country"],
      expirationDate: json["expiration_date"],
      fingerprint: json["fingerprint"]);

  Map<String, dynamic> toJson() => {
        "cardholder_id_number": cardholderIdNumber,
        "cardholder_id_type": cardholderIdType,
        "cardholder_name": cardholderName,
        "client_id": clientId,
        "customer_id": customerId,
        "date_created": dateCreated.toIso8601String(),
        "date_last_updated": dateLastUpdated.toIso8601String(),
        "first_six_digits": firstSixDigits,
        "id": id,
        "id_card": idCard,
        "last_four_digits": lastFourDigits,
        "default_card": defaultCard,
        "brand": brand,
        "country": country,
        "expiration_date": expirationDate,
        "fingerprint": fingerprint
      };

  static List<TasksListModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => TasksListModel.fromJson(item)).toList();
  } */
}
