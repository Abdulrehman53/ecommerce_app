import 'package:ecommerce_app/src/features/cart/data/remote/fake_remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:ecommerce_app/src/features/cart/domain/shopping_cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// API for reading, watching and writing cart data for a specific user ID
abstract class RemoteCartRepository {
  Future<Cart> fetchCart(String uid);
    Future<ShoppingCart> fetchShoppingCart(String uid);

  Stream<Cart> watchCart(String uid);

  Future<void> setCart(String uid, Cart cart);
   Future<void> setShoppingCart(String uid, ShoppingCart cart);
}

final remoteCartRepositoryProvider = Provider<RemoteCartRepository>((ref) {
  // TODO: replace with "real" remote cart repository
  return FakeRemoteCartRepository(addDelay: false);
});
