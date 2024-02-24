import 'package:ecommerce_app/src/common_widgets/component_text_widgets.dart';
import 'package:ecommerce_app/src/common_widgets/empty_placeholder_widget.dart';
import 'package:ecommerce_app/src/constants/breakpoints.dart';
import 'package:ecommerce_app/src/features/cart/presentation/cart_total/cart_total_with_cta.dart';
import 'package:ecommerce_app/src/features/products/presentation/products_list/products_list_screen.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/models/product_model.dart';
import 'package:ecommerce_app/src/models/single_product_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/common_widgets/decorated_box_with_shadow.dart';
import 'package:ecommerce_app/src/common_widgets/responsive_center.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';

/// Responsive widget showing the cart items and the checkout button
class ShoppingCartItemsBuilder extends StatelessWidget {
  const ShoppingCartItemsBuilder({
    super.key,
    required this.items,
    required this.itemBuilder,
  });
  final Set<SingleProduct> items;
  final Widget Function(BuildContext, SingleProduct, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    // If there are no items, show a placeholder
    if (items.isEmpty) {
      return EmptyPlaceholderWidget(
        message: 'Your shopping cart is empty'.hardcoded,
      );
    }
    // ! MediaQuery is used on the assumption that the widget takes up the full
    // ! width of the screen. If that's not the case, LayoutBuilder should be
    // ! used instead.
    final screenWidth = MediaQuery.of(context).size.width;
    // * on wide layouts, show a list of items on the left and the checkout
    // * button on the right
    if (screenWidth >= Breakpoint.tablet) {
      int totalPrice = 0;
      for (int i = 0; i < items.length; i++) {
        totalPrice = totalPrice +
            (int.parse(items.elementAt(i).data!.price ?? '0') *
                items.elementAt(i).data!.selectedQty);
      }
      return ResponsiveCenter(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Row(
          children: [
            Flexible(
              // use 3 flex units for the list of items
              flex: 3,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
                itemBuilder: (context, index) {
                  final item = items.elementAt(index);
                  return itemBuilder(context, item, index);
                },
                itemCount: items.length,
              ),
            ),
            gapW16,
            Flexible(
              // use 1 flex unit for the checkout button
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
                child: CartTotalWithCTA(
                  cartTotal: totalPrice,
                ),
              ),
            )
          ],
        ),
      );
    } else {
      int totalPrice = 0;
      for (int i = 0; i < items.length; i++) {
        totalPrice = totalPrice +
            (int.parse(items.elementAt(i).data!.price ?? '0') *
                items.elementAt(i).data!.selectedQty);
      }
      // * on narrow layouts, show a [Column] with a scrollable list of items
      // * and a pinned box at the bottom with the checkout button
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(Sizes.p16),
              itemBuilder: (context, index) {
                var item;
                if (index != items.length) item = items.elementAt(index);
                return index == items.length
                    ? InkWell(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => ProductsListScreen()),
                              (Route<dynamic> route) => false);
                        },
                        child: ComponentText.buildTextWidget(
                            title: 'Add More Items',
                            textDecoration: TextDecoration.underline),
                      )
                    : itemBuilder(context, item, index);
              },
              itemCount: items.length + 1,
            ),
          ),
          DecoratedBoxWithShadow(
            child: CartTotalWithCTA(
              cartTotal: totalPrice,
            ),
          ),
        ],
      );
    }
  }
}
