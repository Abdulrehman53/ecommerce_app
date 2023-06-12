import 'package:ecommerce_app/config/router.dart';
import 'package:ecommerce_app/src/features/cart/presentation/cart_total/cart_total_text.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';

import '../../../../common_widgets/primary_button.dart';
import '../../../place_order_screen.dart';

/// Widget for showing the shopping cart total with a checkout button
class CartTotalWithCTA extends StatelessWidget {
  final int cartTotal;
  const CartTotalWithCTA(
      {super.key, required this.cartTotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Total:$cartTotal',
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        gapH8,
      
       
        PrimaryButton(
          text: 'Checkout',
          isLoading: false,
          onPressed: () {
            AppRouter.goToNextScreen(context, PlaceOrderScreen(totalPric: cartTotal,));
          },
        ),
         gapH8,
      ],
    );
  }
}
