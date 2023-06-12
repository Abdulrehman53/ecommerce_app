// To parse this JSON data, do
//
//     final baseModel = baseModelFromMap(jsonString);

import 'dart:convert';

class BaseModel {
    BaseModel({
        this.status,
        this.message,
        this.extrainfo,
    });

    bool? status;
    String? message;
    String? extrainfo;

    factory BaseModel.fromJson(String str) => BaseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BaseModel.fromMap(Map<String, dynamic> json) => BaseModel(
        status: json["status"],
        message: json["message"],
        extrainfo: json["extrainfo"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "extrainfo": extrainfo,
    };
}
