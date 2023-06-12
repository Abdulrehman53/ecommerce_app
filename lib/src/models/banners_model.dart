// To parse this JSON data, do
//
//     final bannersModel = bannersModelFromMap(jsonString);

import 'dart:convert';

class BannersModel {
    int? statusCode;
    String? message;
    bool? error;
    List<Datum>? data;

    BannersModel({
        this.statusCode,
        this.message,
        this.error,
        this.data,
    });

    factory BannersModel.fromJson(String str) => BannersModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BannersModel.fromMap(Map<String, dynamic> json) => BannersModel(
        statusCode: json["status_code"],
        message: json["message"],
        error: json["error"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status_code": statusCode,
        "message": message,
        "error": error,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Datum {
    String? image;
    String? link;

    Datum({
        this.image,
        this.link,
    });

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        image: json["image"],
        link: json["link"],
    );

    Map<String, dynamic> toMap() => {
        "image": image,
        "link": link,
    };
}
