import 'dart:math';

import 'package:ecommerce_app/app/app_state.dart';
import 'package:ecommerce_app/src/common_widgets/async_value_widget.dart';
import 'package:ecommerce_app/src/common_widgets/component_text_widgets.dart';
import 'package:ecommerce_app/src/constants/constants_colors.dart';
import 'package:ecommerce_app/src/features/cart/presentation/shopping_cart/shopping_cart_screen_controller.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/models/product_model.dart';
import 'package:ecommerce_app/src/models/single_product_model.dart';
import 'package:ecommerce_app/src/utils/async_value_ui.dart';
import 'package:ecommerce_app/src/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/common_widgets/custom_image.dart';
import 'package:ecommerce_app/src/common_widgets/item_quantity_selector.dart';
import 'package:ecommerce_app/src/common_widgets/responsive_two_column_layout.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows a shopping cart item (or loading/error UI if needed)
class ShoppingCartItem extends ConsumerWidget {
  const ShoppingCartItem({
    super.key,
    required this.item,
    required this.itemIndex,
    this.isEditable = true,
  });
  final SingleProduct item;
  final int itemIndex;

  /// if true, an [ItemQuantitySelector] and a delete button will be shown
  /// if false, the quantity will be shown as a read-only label (used in the
  /// [PaymentPage])
  final bool isEditable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   // final productValue = ref.watch(productProvider(item.productId));
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: ShoppingCartItemContents(
    
              item: item,
              itemIndex: itemIndex,
              isEditable: isEditable,
            ),
          ),
        
      ),
    );
  }
}

/// Shows a shopping cart item for a given product
class ShoppingCartItemContents extends ConsumerWidget {
  const ShoppingCartItemContents({
    super.key,
    required this.item,
    required this.itemIndex,
    required this.isEditable,
  });
 
  final SingleProduct item;
  final int itemIndex;
  final bool isEditable;

  // * Keys for testing using find.byKey()
  static Key deleteKey(int index) => Key('delete-$index');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    return ResponsiveTwoColumnLayout(
      startFlex: 1,
      endFlex: 1,
      breakpoint: 320,
      startContent: CustomImage(imageUrl: item.data!.images![0]),
      spacing: Sizes.p8,
      endContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         
          ComponentText.buildTextWidget(title: item.data!.title??'',color: ConstantColor.primaryColor,fontWeight: FontWeight.bold),
          gapH24,
          Text('RS${item.data!.price}', style: Theme.of(context).textTheme.headline5),
          gapH24,
          isEditable
              // show the quantity selector and a delete button
              ? EditOrRemoveItemWidget(
                
                  item: item,
                  itemIndex: itemIndex,
                )
              // else, show the quantity as a read-only label
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
                  child: Text(
                    'Quantity: ${item.data!.selectedQty}'.hardcoded,
                  ),
                ),
        ],
      ),
    );
  }
}

// custom widget to show the quantity selector and a delete button
class EditOrRemoveItemWidget extends ConsumerWidget {
  const EditOrRemoveItemWidget({
    super.key,
 
    required this.item,
    required this.itemIndex,
  });

  final SingleProduct item;
  final int itemIndex;

  // * Keys for testing using find.byKey()
  static Key deleteKey(int index) => Key('delete-$index');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
       ref.listen<AsyncValue<void>>(
      shoppingCartScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    
   
    final state = ref.watch(shoppingCartScreenControllerProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ItemQuantitySelector(
          quantity: item.data!.selectedQty,
          maxQuantity: min(10, 10),
          itemIndex: itemIndex,
          onChanged:/* (val){
            SingleProduct singleProduct = SingleProduct(data: item.data);
            ApplicationState.instance.cartProducts.removeWhere((product) => product.data!.id == item.data!.id );
            singleProduct.data!.selectedQty = val;
             ApplicationState.instance.cartProducts.add(singleProduct);
             

          } */  state.isLoading
              ? null
              : (quantity) {
                       item.data!.selectedQty =quantity;
                        ref
                            .read(shoppingCartScreenControllerProvider.notifier)
                            .updateItemQuantity(item.data!.id.toString(), quantity);
                      }
        ),
        IconButton(
          key: deleteKey(itemIndex),
          icon: Icon(Icons.delete, color: Colors.red[700]),
          onPressed:
               () { 
                ApplicationState.instance.cartProducts.remove(item);
                ref
                  .read(shoppingCartScreenControllerProvider.notifier)
                  .removeItemById(item.data!.id.toString()); 
               }
        ),
        const Spacer(),
      ],
    );
  }
}
