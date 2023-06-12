// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromMap(jsonString);

import 'dart:convert';

class CategoriesModel {
    CategoriesModel({
        this.statusCode,
        this.message,
        this.error,
        this.data,
    });

    int? statusCode;
    String? message;
    bool? error;
    List<CategoryDatum>? data;

    factory CategoriesModel.fromJson(String str) => CategoriesModel.fromMap(json.decode(str));



    factory CategoriesModel.fromMap(Map<String, dynamic> json) => CategoriesModel(
        statusCode: json["status_code"],
        message: json["message"],
        error: json["error"],
        data: List<CategoryDatum>.from(json["data"].map((x) => CategoryDatum.fromMap(x))),
    );

  
}

class CategoryDatum {
    CategoryDatum({
        this.id,
        this.name,
        this.image,
        this.bannerImage,
        this.description,
        this.type,
        this.featured,
        this.createdAt,
    });

    String? id;
    String? name;
    String? image;
    String? bannerImage;
    String? description;
    String? type;
    bool? featured;
    DateTime? createdAt;

    factory CategoryDatum.fromJson(String str) => CategoryDatum.fromMap(json.decode(str));

   

    factory CategoryDatum.fromMap(Map<String, dynamic> json) => CategoryDatum(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        bannerImage: json["banner_image"],
        description: json["description"],
        type: json["type"],
        featured: json["featured"],
        createdAt: DateTime.parse(json["created_at"]),
    );

   
}





