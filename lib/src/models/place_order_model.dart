// To parse this JSON data, do
//
//     final placeOrderModel = placeOrderModelFromMap(jsonString);

import 'dart:convert';

class PlaceOrderModel {
    PlaceOrderModel({
        this.address1,
        this.address2,
        this.city,
        this.province,
        this.country,
        this.postalCode,
        this.name,
        this.email,
        this.phone,
        this.couponCode,
        this.total,
        this.ipAddress,
        this.paymentMethod,
        this.productDetails,
    });

    String? address1;
    String? address2;
    String? city;
    String? province;
    String? country;
    String? postalCode;
    String? name;
    String? email;
    String? phone;
    String? couponCode;
    String? total;
    String? ipAddress;
    String? paymentMethod;
    List<ProductDetail>? productDetails;

    factory PlaceOrderModel.fromJson(String str) => PlaceOrderModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PlaceOrderModel.fromMap(Map<String, dynamic> json) => PlaceOrderModel(
        address1: json["address1"],
        address2: json["address2"],
        city: json["city"],
        province: json["province"],
        country: json["country"],
        postalCode: json["postal_code"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        total: json["total"],
        ipAddress: json["ip_address"],
        paymentMethod: json["payment_method"],
        productDetails: List<ProductDetail>.from(json["product_details"].map((x) => ProductDetail.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "address1": address1,
        "address2": address2,
        "city": city,
        "province": province,
        "country": country,
        "postal_code": postalCode,
        "name": name,
        "email": email,
        "phone": phone,
        "coupon_code": couponCode,
        "total": total,
        "ip_address": ipAddress,
        "payment_method": paymentMethod,
        "product_details": List<dynamic>.from(productDetails!.map((x) => x.toMap())),
    };
}

class ProductDetail {
    ProductDetail({
        this.id,
        this.quantity,
        this.name,
    });

    int? id;
    int? quantity;
    String? name;

    factory ProductDetail.fromJson(String str) => ProductDetail.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductDetail.fromMap(Map<String, dynamic> json) => ProductDetail(
        id: json["id"],
        quantity: json["quantity"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "quantity": quantity,
        "name": name,
    };
}
