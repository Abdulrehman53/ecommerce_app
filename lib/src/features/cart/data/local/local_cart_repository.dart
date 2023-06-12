import 'package:ecommerce_app/src/features/cart/domain/shopping_cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';

/// API for reading, watching and writing local cart data (guest user)
abstract class LocalCartRepository {
  Future<Cart> fetchCart();
  Future<ShoppingCart> fetchShoppingCart();

  Stream<Cart> watchCart();

  Future<void> setCart(Cart cart);
   Future<void> setKeuneCart(ShoppingCart cart);
}

final localCartRepositoryProvider = Provider<LocalCartRepository>((ref) {
  // * Override this in the main method
  throw UnimplementedError();
});
