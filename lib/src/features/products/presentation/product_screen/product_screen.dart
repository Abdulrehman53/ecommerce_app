import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/config/router.dart';
import 'package:ecommerce_app/src/common_widgets/async_value_widget.dart';
import 'package:ecommerce_app/src/common_widgets/component_text_widgets.dart';
import 'package:ecommerce_app/src/constants/constants_colors.dart';
import 'package:ecommerce_app/src/features/cart/presentation/add_to_cart/add_to_cart_widget.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/products/presentation/home_app_bar/home_app_bar.dart';
import 'package:ecommerce_app/src/features/products/presentation/product_screen/leave_review_action.dart';
import 'package:ecommerce_app/src/features/products/presentation/product_screen/product_average_rating.dart';
import 'package:ecommerce_app/src/features/reviews/presentation/product_reviews/product_reviews_list.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/common_widgets/empty_placeholder_widget.dart';
import 'package:ecommerce_app/src/models/single_product_model.dart';
import 'package:ecommerce_app/src/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/common_widgets/custom_image.dart';
import 'package:ecommerce_app/src/common_widgets/responsive_center.dart';
import 'package:ecommerce_app/src/common_widgets/responsive_two_column_layout.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app/app_state.dart';
import '../../../../models/product_model.dart';
import '../../../../repositories/app_repo.dart';
import '../../../cart/presentation/shopping_cart/shopping_cart_screen.dart';
import '../home_app_bar/shopping_cart_icon.dart';
import '../products_list/products_list_screen.dart';

/// Shows the product page for a given product ID.
class ProductScreen extends StatefulWidget {
  ProductScreen(
      {super.key, required this.productId, required this.productName});
  final String productId, productName;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  SingleProduct? productModel;
  @override
  void initState() {
    super.initState();

    getProuductById();
  }

  getProuductById() async {
    productModel = await AppRepo().getProduct(widget.productId);
    setState(() {});
  }

  static const shoppingCartIconKey = Key('shopping-cart');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, 'Yep!');
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        actions: [
          Stack(
            children: [
              Center(
                child: IconButton(
                  key: shoppingCartIconKey,
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    AppRouter.goToNextScreen(context, ShoppingCartScreen());
                  },
                ),
              ),
              Positioned(
                top: Sizes.p4,
                right: Sizes.p4,
                child: ShoppingCartIconBadge(
                    itemsCount: ApplicationState.instance.cartProducts.length),
              ),
            ],
          )
        ],
      ),
      body: Consumer(
        builder: (context, ref, _) {
          return productModel == null
              ? Container()
              : CustomScrollView(
                  slivers: [
                    ResponsiveSliverCenter(
                      padding: const EdgeInsets.all(Sizes.p16),
                      child: ProductDetails(
                        product: productModel,
                        callback: () {
                          AppRouter.goToNextScreen(
                              context, ShoppingCartScreen());
                          setState(() {
                            print('object');
                          });
                        },
                      ),
                    ),
                    ResponsiveSliverCenter(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      child: ComponentText.buildTextWidget(
                          title: 'INGREDIENTS',
                          maxLines: 1,
                          fontSize: 18,
                          color: ConstantColor.primaryColor),
                    )),
                    ResponsiveSliverCenter(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      child: Column(
                        children: [
                          ComponentText.buildTextWidget(
                              title: productModel!.data!.ingredients ?? '',
                              maxLines: 6,
                              fontSize: 14),
                          gapH16,
                          ComponentText.buildTextWidget(
                              title:
                                  'Usage: ${productModel!.data!.useageDirections}',
                              maxLines: 6,
                              color: Colors.grey,
                              fontSize: 12),
                          gapH48,
                        ],
                      ),
                    )),
                    //ProductReviewsList(productId: productId),
                  ],
                );
        },
      ),
    );
  }
}

/// Shows all the product details along with actions to:
/// - leave a review
/// - add to cart
class ProductDetails extends ConsumerWidget {
  ProductDetails({super.key, required this.callback, required this.product});
  final SingleProduct? product;
  final Function callback;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveTwoColumnLayout(
      startContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Image.network(
            product!.data!.images![1],
            fit: BoxFit.contain,
          ),
        ),
      ),
      spacing: Sizes.p16,
      endContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(product!.data!.title ?? '',
                  style: Theme.of(context).textTheme.headline6),
              gapH8,
              Row(
                children: [
                  Text(product!.data!.qty ?? ''),
                ],
              ),
              // Only show average if there is at least one rating

              gapH8,
              const Divider(),
              gapH8,
              ComponentText.buildTextWidget(
                  title: 'RS. ${product!.data!.price}',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              gapH8,
              ComponentText.buildTextWidget(
                  title: product!.data!.description ?? '', maxLines: 6),
              gapH8,

              const Divider(),
              gapH8,
              AddToCartWidget(
                product: product,
                callback: () {
                  callback();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget carosolWidget() {
    return CarouselSlider(
      carouselController: _controller,
      items: product!.data!.images!.map((imgurl) {
        return Builder(builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            //margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Image.network(
              imgurl,
              fit: BoxFit.contain,
            ),
          );
        });
      }).toList(),
      options: CarouselOptions(
        height: 180,
        viewportFraction: 0.8,
        initialPage: 0,
        enlargeCenterPage: true,
        autoPlay: true,
        onPageChanged: (index, reason) {},
      ),
    );
  }
}
