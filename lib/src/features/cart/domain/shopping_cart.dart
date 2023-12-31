import 'dart:convert';

import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/models/product_model.dart';
import 'package:flutter/foundation.dart';

import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';

/// Model class representing the shopping cart contents.
class ShoppingCart {
  const ShoppingCart([this.items = const {}]);

  /// All the items in the shopping cart, where:
  /// - key: product ID
  /// - value: quantity
  final Map<int, Product> items;

  Map<String, dynamic> toMap() {
    return {
      'items': items,
    };
  }

  factory ShoppingCart.fromMap(Map<String, dynamic> map) {
    return ShoppingCart(
      Map<int, Product>.from(map['items']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingCart.fromJson(String source) => ShoppingCart.fromMap(json.decode(source));

  @override
  String toString() => 'Cart(items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShoppingCart && mapEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}

extension CartItem on ShoppingCart {
  List<ProductItem> toItemsList() {
    return items.entries.map((entry) {
      return ProductItem(
        product: entry.value,
        quantity: entry.key,
      );
    }).toList();
  }
}
