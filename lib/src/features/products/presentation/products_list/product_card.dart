import 'package:ecommerce_app/src/common_widgets/component_text_widgets.dart';
import 'package:ecommerce_app/src/features/products/presentation/product_screen/product_average_rating.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/common_widgets/custom_image.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/utils/currency_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/product_model.dart';

/// Used to show a single product inside a card.
class ProductCard extends ConsumerWidget {
  const ProductCard({super.key, required this.product, this.onPressed});
  final Product product;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const productCardKey = Key('product-card');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    return InkWell(
      key: productCardKey,
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomImage(imageUrl: product.images![1]),
            gapH16,
            ComponentText.buildTextWidget(
                title: product.title??'', fontWeight: FontWeight.bold,maxLines: 2,fontSize: 12),
                 gapH4,
             ComponentText.buildTextWidget(
                title: product.category??'', fontWeight: FontWeight.normal,fontSize: 13),
           
            gapH8,
             ComponentText.buildTextWidget(
                title: 'PKR ${product.price}', fontWeight: FontWeight.w600,fontSize: 13),
          
          ],
        ),
      ),
    );
  }
}
