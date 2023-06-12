// To parse this JSON data, do
//
//     final tokenModel = tokenModelFromMap(jsonString);

import 'dart:convert';

class TokenModel {
    int? statusCode;
    String? message;
    bool? error;
    Data? data;

    TokenModel({
        this.statusCode,
        this.message,
        this.error,
        this.data,
    });

    factory TokenModel.fromJson(String str) => TokenModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TokenModel.fromMap(Map<String, dynamic> json) => TokenModel(
        statusCode: json["status_code"],
        message: json["message"],
        error: json["error"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "status_code": statusCode,
        "message": message,
        "error": error,
        "data": data?.toMap(),
    };
}

class Data {
    String? token;

    Data({
        this.token,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        token: json["token"],
    );

    Map<String, dynamic> toMap() => {
        "token": token,
    };
}
