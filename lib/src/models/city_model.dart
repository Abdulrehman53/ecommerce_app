// To parse this JSON data, do
//
//     final cityModel = cityModelFromMap(jsonString);

import 'dart:convert';

class CityModel {
    CityModel({
        this.statusCode,
        this.message,
        this.error,
        this.data,
    });

    int? statusCode;
    String? message;
    bool? error;
    List<CityDatum>? data;

    factory CityModel.fromJson(String str) => CityModel.fromMap(json.decode(str));

  

    factory CityModel.fromMap(Map<String, dynamic> json) => CityModel(
        statusCode: json["status_code"],
        message: json["message"],
        error: json["error"],
        data: List<CityDatum>.from(json["data"].map((x) => CityDatum.fromMap(x))),
    );

  
}

class CityDatum {
    CityDatum({
        this.cityCode,
        this.cityName,
    });

    String? cityCode;
    String? cityName;

    factory CityDatum.fromJson(String str) => CityDatum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CityDatum.fromMap(Map<String, dynamic> json) => CityDatum(
        cityCode: json["CITY_CODE"],
        cityName: json["CITY_NAME"],
    );

    Map<String, dynamic> toMap() => {
        "CITY_CODE": cityCode,
        "CITY_NAME": cityName,
    };
    bool operator ==(dynamic other) =>
      other != null && other is CityDatum && this.cityName == other.cityName;

  @override
  int get hashCode => super.hashCode;
}
