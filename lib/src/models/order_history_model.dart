// To parse this JSON data, do
//
//     final orderHistoryModel = orderHistoryModelFromMap(jsonString);

import 'dart:convert';

class OrderHistoryModel {
    OrderHistoryModel({
        this.statusCode,
        this.message,
        this.error,
        this.data,
    });

    int? statusCode;
    String? message;
    bool? error;
    List<Datum>? data;

    factory OrderHistoryModel.fromJson(String str) => OrderHistoryModel.fromMap(json.decode(str));

 
    factory OrderHistoryModel.fromMap(Map<String, dynamic> json) => OrderHistoryModel(
        statusCode: json["status_code"],
        message: json["message"],
        error: json["error"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    );

   
}

class Datum {
    Datum({
        this.id,
        this.orderDetails,
        this.shippingDetails,
        this.trackingNumber,
        this.consignmentNumber,
        this.status,
        this.bxStatus,
        this.notes,
        this.userInfo,
        this.total,
        this.beforeCouponTotal,
        this.couponDetails,
        this.deliveryFee,
        this.datumNew,
        this.paymentMethod,
        this.ipAddress,
        this.orderAt,
    });

    String? id;
    Map<String, OrderDetail>? orderDetails;
    ShippingDetails? shippingDetails;
    String? trackingNumber;
    String? consignmentNumber;
    String? status;
    String? bxStatus;
    String? notes;
    String? userInfo;
    String? total;
    dynamic beforeCouponTotal;
    dynamic couponDetails;
    String? deliveryFee;
    String? datumNew;
    String? paymentMethod;
    String? ipAddress;
    DateTime? orderAt;

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));


    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
       
        shippingDetails: ShippingDetails.fromMap(json["shipping_details"]),
        trackingNumber: json["tracking_number"],
        consignmentNumber: json["consignment_number"],
        status: json["status"],
        bxStatus: json["bx_status"],
        notes: json["notes"],
        userInfo: json["user_info"],
        total: json["total"],
        beforeCouponTotal: json["before_coupon_total"],
        couponDetails: json["coupon_details"],
        deliveryFee: json["delivery_fee"],
        datumNew: json["new"],
        paymentMethod: json["payment_method"],
        ipAddress: json["ip_address"],
        orderAt: DateTime.parse(json["order_at"]),
    );

   
}

class OrderDetail {
    OrderDetail({
        this.type,
        this.id,
        this.sku,
        this.qty,
        this.price,
        this.name,
        this.img,
        this.slug,
        this.weight,
        this.size,
        this.rowid,
        this.subtotal,
    });

    String? type;
    String? id;
    String? sku;
    int? qty;
    int? price;
    String? name;
    String? img;
    String? slug;
    String? weight;
    String? size;
    String? rowid;
    int? subtotal;

    factory OrderDetail.fromJson(String str) => OrderDetail.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OrderDetail.fromMap(Map<String, dynamic> json) => OrderDetail(
        type: json["type"],
        id: json["id"],
        sku: json["sku"],
        qty: json["qty"],
        price: json["price"],
        name: json["name"],
        img: json["img"],
        slug: json["slug"],
        weight: json["weight"],
        size: json["size"],
        rowid: json["rowid"],
        subtotal: json["subtotal"],
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "id": id,
        "sku": sku,
        "qty": qty,
        "price": price,
        "name": name,
        "img": img,
        "slug": slug,
        "weight": weight,
        "size": size,
        "rowid": rowid,
        "subtotal": subtotal,
    };
}

class ShippingDetails {
    ShippingDetails({
        this.address1,
        this.address2,
        this.city,
        this.province,
        this.country,
        this.postalCode,
    });

    String? address1;
    String? address2;
    String? city;
    String? province;
    String? country;
    String? postalCode;

    factory ShippingDetails.fromJson(String str) => ShippingDetails.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ShippingDetails.fromMap(Map<String, dynamic> json) => ShippingDetails(
        address1: json["address1"],
        address2: json["address2"],
        city: json["city"],
        province: json["province"],
        country: json["country"],
        postalCode: json["postal_code"],
    );

    Map<String, dynamic> toMap() => {
        "address1": address1,
        "address2": address2,
        "city": city,
        "province": province,
        "country": country,
        "postal_code": postalCode,
    };
}
