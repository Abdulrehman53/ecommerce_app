import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/models/product_model.dart';

/// A product along with a quantity that can be added to an order/cart
class Item {
  const Item({
    required this.productId,
    required this.quantity,
  });
  final ProductID productId;
  final int quantity;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item &&
        other.productId == productId &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => productId.hashCode ^ quantity.hashCode;
}
class ProductItem {
  const ProductItem({
    required this.product,
    required this.quantity,
  });
  final Product product;
  final int quantity;


  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;
}
