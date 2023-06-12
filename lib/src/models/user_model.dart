// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

class UserModel {
    UserModel({
        this.statusCode,
        this.message,
        this.error,
        this.data,
    });

    int? statusCode;
    String? message;
    bool? error;
    Data? data;

    factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

    factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        statusCode: json["status_code"],
        message: json["message"],
        error: json["error"],
        data: Data.fromMap(json["data"]),
    );

   
}

class Data {
    Data({
        this.id,
        this.email,
        this.password,
        this.fullName,
        this.phoneNumber,
        this.address1,
        this.address2,
        this.country,
        this.province,
        this.city,
        this.postalCode,
        this.createdAt,
    });

    String? id;
    String? email;
    String? password;
    String? fullName;
    dynamic phoneNumber;
    dynamic address1;
    dynamic address2;
    dynamic country;
    dynamic province;
    dynamic city;
    dynamic postalCode;
    DateTime? createdAt;

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));



    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        address1: json["address1"],
        address2: json["address2"],
        country: json["country"],
        province: json["province"],
        city: json["city"],
        postalCode: json["postal_code"],
        createdAt: DateTime.parse(json["created_at"]),
    );


}
