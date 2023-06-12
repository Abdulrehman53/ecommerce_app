// To parse this JSON data, do
//
//     final laywerModel = laywerModelFromMap(jsonString);

import 'dart:convert';

class ScheduleModel {
  ScheduleModel({
    this.records,
    this.message,
  });

  Records? records;
  String? message;

  factory ScheduleModel.fromJson(String str) =>
      ScheduleModel.fromMap(json.decode(str));

  factory ScheduleModel.fromMap(Map<String, dynamic> json) => ScheduleModel(
        records: Records.fromMap(json["records"]),
        message: json["message"],
      );
}

class Records {
  Records({
    this.weekDays,
   
  });

  List<Weekday>? weekDays;

  factory Records.fromJson(String str) => Records.fromMap(json.decode(str));

  factory Records.fromMap(Map<String, dynamic> json) {
   List<Weekday>? weekDays=[];
    for(int index = 0;index<  json.keys.length;index++ ){
      weekDays.add(Weekday.fromMap(json.values.elementAt(0)));
    }
    return Records(weekDays: weekDays);
  }
}

class Weekday {
  Weekday({
    this.name,
    this.value,
    this.count,
    this.dayId,
    this.slots,
  });

  String? name;
  bool? value;
  int? count;
  int? dayId;
  List<Slot>? slots;

  factory Weekday.fromJson(String str) => Weekday.fromMap(json.decode(str));

  factory Weekday.fromMap(Map<String, dynamic> json) => Weekday(
        name: json["name"],
        value: json["value"],
        count: json["count"],
        dayId: json["day_id"],
        slots: List<Slot>.from(json["slots"].map((x) => Slot.fromMap(x))),
      );
}

class Slot {
  Slot({
    this.fromTime,
    this.toTime,
  });

  String? fromTime;
  String? toTime;

  factory Slot.fromJson(String str) => Slot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Slot.fromMap(Map<String, dynamic> json) => Slot(
        fromTime: json["from_time"],
        toTime: json["to_time"],
      );

  Map<String, dynamic> toMap() => {
        "from_time": fromTime,
        "to_time": toTime,
      };
}
