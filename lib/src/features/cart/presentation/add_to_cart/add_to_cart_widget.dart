import 'dart:math';

import 'package:ecommerce_app/app/app_state.dart';
import 'package:ecommerce_app/src/features/authentication/auth/login_screen.dart';
import 'package:ecommerce_app/src/features/cart/application/cart_service.dart';
import 'package:ecommerce_app/src/features/cart/presentation/add_to_cart/add_to_cart_controller.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/models/single_product_model.dart';
import 'package:ecommerce_app/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/common_widgets/item_quantity_selector.dart';
import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/AppKeys.dart';
import '../../../../helpers/PrefManager.dart';
import '../../../../models/product_model.dart';

/// A widget that shows an [ItemQuantitySelector] along with a [PrimaryButton]
/// to add the selected quantity of the item to the cart.
class AddToCartWidget extends ConsumerWidget {
  final Function callback;
  const AddToCartWidget(
      {super.key, required this.callback, required this.product});
  final SingleProduct? product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<int>>(
      addToCartControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final state = ref.watch(addToCartControllerProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Quantity:'.hardcoded),
            ItemQuantitySelector(
                quantity: state.value!,
                // let the user choose up to the available quantity or
                // 10 items at most
                maxQuantity: min(10, 10),
                onChanged: state.isLoading
                    ? null
                    : (quantity) {
                        product!.data!.selectedQty = quantity;
                        ref
                            .read(addToCartControllerProvider.notifier)
                            .updateQuantity(quantity);
                      }),
          ],
        ),
        gapH8,
        const Divider(),
        gapH8,
        PrimaryButton(
            isLoading: state.isLoading,
            // only enable the button if there is enough stock
            onPressed: () async {
              String? userId = await PrefManager().read(AppKeys.Id);
              if (userId.isNotEmpty) {
                ApplicationState.instance.cartProducts.add(product!);
                callback();

                ref
                    .read(addToCartControllerProvider.notifier)
                    .addItem(product!.data!.id.toString());
                    
              }else{
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return LoginScreen();
                }));
              }
            },
            text: 'Add to Cart'.hardcoded),
        /* if (product.qty > 0 && availableQuantity == 0) ...[
          gapH8,
          Text(
            'Already added to cart'.hardcoded,
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          ),
        ] */
      ],
    );
  }
}
