// To parse this JSON data, do
//
//     final orderResponseModel = orderResponseModelFromMap(jsonString);

import 'dart:convert';

class OrderResponseModel {
    OrderResponseModel({
        this.statusCode,
        this.message,
        this.error,
        this.data,
    });

    int? statusCode;
    String? message;
    bool? error;
    OrderData? data;

    factory OrderResponseModel.fromJson(String str) => OrderResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OrderResponseModel.fromMap(Map<String, dynamic> json) => OrderResponseModel(
        statusCode: json["status_code"],
        message: json["message"],
        error: json["error"],
        data: OrderData.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "status_code": statusCode,
        "message": message,
        "error": error,
        "data": data!.toMap(),
    };
}

class OrderData {
    OrderData({
        this.message,
        this.trackingNumber,
    });

    String? message;
    String? trackingNumber;

    factory OrderData.fromJson(String str) => OrderData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OrderData.fromMap(Map<String, dynamic> json) => OrderData(
        message: json["message"],
        trackingNumber: json["tracking_number"],
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "tracking_number": trackingNumber,
    };
}
