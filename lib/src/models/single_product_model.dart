// To parse this JSON data, do
//
//     final productModel = productModelFromMap(jsonString);

import 'dart:convert';

class SingleProduct {
    SingleProduct({
        this.statusCode,
        this.message,
        this.error,
        this.data,
    });

    int? statusCode;
    String? message;
    bool? error;
    SingleProductData? data;

    factory SingleProduct.fromJson(String str) => SingleProduct.fromMap(json.decode(str));

   

    factory SingleProduct.fromMap(Map<String, dynamic> json) => SingleProduct(
        statusCode: json["status_code"],
        message: json["message"],
        error: json["error"],
        data: SingleProductData.fromMap(json["data"]),
    );

  
}

class SingleProductData {
  SingleProductData({
    this.selectedQty = 1,
    this.id,
    this.title,
    this.slug,
    this.qty,
    this.smallDescription,
    this.price,
    this.salePrice,
    this.saleSchedule,
    this.scheduledSalePrice,
    this.saleStartDate,
    this.saleEndDate,
    this.description,
    this.useageDirections,
    this.holdFactor,
    this.shineFactor,
    this.watchId,
    this.sku,
    this.category,
    this.subCategory,
    this.stock,
    this.barcode,
    this.ingredients,
    this.shade,
    this.number,
    this.weight,
    this.images,
    this.createdAt,
  });
  int selectedQty;
  int? id;
  String? title;
  String? slug;
  String? qty;
  SmallDescription? smallDescription;
  String? price;
  String? salePrice;
  dynamic saleSchedule;
  dynamic scheduledSalePrice;
  dynamic saleStartDate;
  dynamic saleEndDate;
  String? description;
  String? useageDirections;
  String? holdFactor;
  String? shineFactor;
  String? watchId;
  String? sku;
  String? category;
  SubCategory? subCategory;
  String? stock;
  String? barcode;
  String? ingredients;
  String? shade;
  String? number;
  String? weight;
  List<String>? images;
  DateTime? createdAt;

  factory SingleProductData.fromJson(String str) =>
      SingleProductData.fromMap(json.decode(str));

  factory SingleProductData.fromMap(Map<String, dynamic> json) => SingleProductData(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        price: json["price"],
        salePrice: json["sale_price"] == null ? null : json["sale_price"],
        saleSchedule: json["sale_schedule"],
        scheduledSalePrice: json["scheduled_sale_price"],
        saleStartDate: json["sale_start_date"],
        saleEndDate: json["sale_end_date"],
        description: json["description"],
        useageDirections: json["useage_directions"],
        holdFactor: json["hold_factor"],
        shineFactor: json["shine_factor"],
        watchId: json["watch_id"],
        sku: json["sku"],
        category: json["category"],
        stock: json["stock"],
        barcode: json["barcode"],
        ingredients: json["ingredients"],
        shade: json["shade"],
        number: json["number"],
        weight: json["weight"],
        qty: json["qty"],
        images: List<String>.from(json["image"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
      );
}

enum Qty { THE_150_ML, THE_60_ML }

enum SmallDescription { DIRECT_INSTANT_COLOR, PERMANENT_HAIR_COLOR }

enum SubCategory { DIRECT_DYE_COLOR_CRAVING, PERMANENT_TINTA_COLOR }
