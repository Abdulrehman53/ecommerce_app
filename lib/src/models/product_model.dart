// To parse this JSON data, do
//
//     final productModel = productModelFromMap(jsonString);

import 'dart:convert';

class ProductModel {
  ProductModel({
    this.statusCode,
    this.message,
    this.error,
    this.data,
  });

  int? statusCode;
  String? message;
  bool? error;
  ProductDatum? data;

  factory ProductModel.fromJson(String str) =>
      ProductModel.fromMap(json.decode(str));

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        statusCode: json["status_code"],
        message: json["message"],
        error: json["error"],
        data: ProductDatum.fromMap(json["data"]),
      );
}

class ProductDatum {
  ProductDatum({
    this.products,
    this.totalProducts,
    this.totalPages,
    this.nextPageUrl,
  });

  List<Product>? products;
  int? totalProducts;
  int? totalPages;
  String? nextPageUrl;

  factory ProductDatum.fromJson(String str) =>
      ProductDatum.fromMap(json.decode(str));

  factory ProductDatum.fromMap(Map<String, dynamic> json) => ProductDatum(
        products:
            List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
        totalProducts: json["totalProducts"],
        totalPages: json["totalPages"],
        nextPageUrl: json["nextPageUrl"],
      );
}

class Product {
  Product({
    this.id,
    this.title,
    this.price,
    this.salePrice,
    this.category,
    this.images,
    this.createdAt,
  });

  String? id;
  String? title;
  String? price;
  String? salePrice;
  String? category;
  int selectedQty = 1;
  List<String>? images;
  DateTime? createdAt;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        salePrice: json["sale_price"] == null ? null : json["sale_price"],
        images: List<String>.from(json["images"].map((x) => x)),
        category: json['sub_category'],
        createdAt: DateTime.parse(json["created_at"]),
      );
}

