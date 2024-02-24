import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:ecommerce_app/config/router.dart';
import 'package:ecommerce_app/src/common_widgets/component_button.dart';
import 'package:ecommerce_app/src/common_widgets/component_sized_box.dart';
import 'package:ecommerce_app/src/common_widgets/component_text_widgets.dart';
import 'package:ecommerce_app/src/constants/AppKeys.dart';
import 'package:ecommerce_app/src/constants/constants_colors.dart';
import 'package:ecommerce_app/src/features/products/presentation/products_list/products_list_screen.dart';
import 'package:ecommerce_app/src/features/thankyou_screen.dart';
import 'package:ecommerce_app/src/models/city_model.dart';
import 'package:ecommerce_app/src/models/order_response_model.dart';
import 'package:ecommerce_app/src/models/place_order_model.dart';
import 'package:ecommerce_app/src/repositories/app_repo.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../app/app_state.dart';
import '../../config/validations.dart';
import '../common_widgets/component_form_fields.dart';
import '../helpers/PrefManager.dart';
import '../models/single_product_model.dart';

class PlaceOrderScreen extends StatefulWidget {
  int totalPric;
  PlaceOrderScreen({Key? key, required this.totalPric}) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  PlaceOrderModel placeOrderModel = PlaceOrderModel(productDetails: []);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  CityDatum _selectedCity = CityDatum(cityName: 'Lahore');
  CityModel? cityModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCities();
  }

  getCities() async {
    cityModel = await AppRepo().apiGetCities();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ComponentText.buildTextWidget(
            title: 'Checkout',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Form(
          key: _key,
          child: ListView(children: [
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => ProductsListScreen()),
                      (Route<dynamic> route) => false);
                },
                child: ComponentText.buildTextWidget(
                    title: 'Add More Items',
                    textDecoration: TextDecoration.underline),
              ),
            ),
            ComponentSizedBox.topMargin(size: 8),
            ComponentText.buildTextWidget(
                title: 'Contact Information',
                fontWeight: FontWeight.bold,
                fontSize: 18),
            ComponentSizedBox.topMargin(size: 8),
            ComponentText.buildTextWidget(
                title:
                    'We\'ll use these details to send you updates about your order.',
                fontSize: 12),
            ComponentSizedBox.topMargin(size: 8),
            FormFieldComponent(
              hint: 'Full Name'.toUpperCase(),
              keyboardType: TextInputType.text,
              onSaved: (val) {
                placeOrderModel.name = val;
              },
              validator: (value) {
                return Validation.validateValue(
                    value!, 'Full Name'.toUpperCase(), false);
              },
            ),
            ComponentSizedBox.topMargin(size: 8),
            FormFieldComponent(
              hint: 'Email'.toUpperCase(),
              keyboardType: TextInputType.text,
              onSaved: (val) {
                placeOrderModel.email = val;
              },
              validator: (value) {
                return Validation.validateValue(
                    value!, 'Email'.toUpperCase(), false);
              },
            ),
            ComponentSizedBox.topMargin(size: 8),
            FormFieldComponent(
              hint: 'Phone Number'.toUpperCase(),
              keyboardType: TextInputType.text,
              onSaved: (val) {
                placeOrderModel.phone = val;
              },
              validator: (value) {
                return Validation.validateValue(
                    value!, 'Phone Number'.toUpperCase(), false);
              },
            ),
            ComponentSizedBox.topMargin(size: 24),
            ComponentText.buildTextWidget(
                title: 'Shipping Information',
                fontWeight: FontWeight.bold,
                fontSize: 18),
            ComponentSizedBox.topMargin(size: 8),
            ComponentText.buildTextWidget(
                title:
                    'Enter the physical address where you want us to deliver your order.',
                fontSize: 12),
            ComponentSizedBox.topMargin(size: 8),
            FormFieldComponent(
              hint: 'Complete Address'.toUpperCase(),
              keyboardType: TextInputType.text,
              onSaved: (val) {
                placeOrderModel.address1 = val;
              },
              validator: (value) {
                return Validation.validateValue(
                    value!, 'Complete Address'.toUpperCase(), false);
              },
            ),
            ComponentSizedBox.topMargin(size: 8),
            FormFieldComponent(
              hint: 'Apartment,suit,unit(optional)'.toUpperCase(),
              keyboardType: TextInputType.text,
              onSaved: (val) {
                placeOrderModel.address2 = val;
              },
            ),
            ComponentSizedBox.topMargin(size: 8),
            FormFieldComponent(
              hint: 'Province'.toUpperCase(),
              keyboardType: TextInputType.text,
              onSaved: (val) {
                placeOrderModel.province = val;
              },
              validator: (value) {
                return Validation.validateValue(
                    value!, 'Province'.toUpperCase(), false);
              },
            ),
            ComponentSizedBox.topMargin(size: 8),
            cityModel == null
                ? Container()
                : DropdownButton<CityDatum>(
                    hint: Text('City'), // Not necessary for Option 1
                    value: _selectedCity,
                    onChanged: (CityDatum? newValue) {
                      setState(() {
                        _selectedCity = newValue!;
                      });
                    },
                    items: cityModel!.data!.map((city) {
                      return DropdownMenuItem<CityDatum>(
                        child: Text(city.cityName!),
                        value: city,
                      );
                    }).toList(),
                  ),
            ComponentSizedBox.topMargin(size: 8),
            FormFieldComponent(
              hint: 'Postal Code'.toUpperCase(),
              keyboardType: TextInputType.text,
              onSaved: (val) {
                placeOrderModel.postalCode = val;
              },
              validator: (value) {
                return Validation.validateValue(
                    value!, 'Postal Code'.toUpperCase(), false);
              },
            ),
            ComponentSizedBox.topMargin(size: 20),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ConstantColor.APP_COLOR.withOpacity(0.1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ComponentText.buildTextWidget(
                      title: 'Order Summary',
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  ComponentSizedBox.topMargin(size: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ComponentText.buildTextWidget(
                          title: 'Product', fontWeight: FontWeight.bold),
                      ComponentText.buildTextWidget(
                          title: 'Total', fontWeight: FontWeight.bold),
                    ],
                  ),
                  ComponentSizedBox.topMargin(size: 10),
                  Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: ApplicationState.instance.cartProducts
                        .map((data) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ComponentText.buildTextWidget(
                                      title:
                                          '${data.data!.title} * ${data.data!.selectedQty}',
                                      fontSize: 13),
                                  ComponentText.buildTextWidget(
                                      title:
                                          'PKR ${int.parse(data.data!.price!) * data.data!.selectedQty}',
                                      fontWeight: FontWeight.bold),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ComponentText.buildTextWidget(
                            title: 'Cart Subtotal',
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        ComponentText.buildTextWidget(
                            title: 'PKR ${widget.totalPric}',
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ComponentText.buildTextWidget(
                            title: 'Order Total',
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        ComponentText.buildTextWidget(
                            title: 'PKR ${widget.totalPric}',
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ComponentSizedBox.topMargin(size: 24),
            Center(
              child: ComponentButton.buildButton(
                  width: 250,
                  title: 'Place Order',
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      _key.currentState!.save();
                      Set<SingleProduct> products =
                          ApplicationState.instance.cartProducts;
                      String email = await PrefManager().read(AppKeys.Email);
                      placeOrderModel.email = email;
                      placeOrderModel.country = 'Pakistan';
                      placeOrderModel.city = _selectedCity.cityName;
                      placeOrderModel.total = widget.totalPric.toString();
                      placeOrderModel.ipAddress = "1.1.1.1";
                      placeOrderModel.paymentMethod = 'COD';

                      for (SingleProduct product in products) {
                        placeOrderModel.productDetails!.add(ProductDetail(
                            id: product.data!.id,
                            quantity: product.data!.selectedQty,
                            name: product.data!.title));
                      }
                      OrderResponseModel orderResponseModel =
                          await AppRepo().apiPlaceOrder(placeOrderModel);
                      Fluttertoast.showToast(msg: 'Order Placed Successfully');
                      AppRouter.goToNextScreen(
                          context,
                          ThankyouScreen(
                            orderResponseModel: orderResponseModel,
                          ));
                    }
                  }),
            )
          ]),
        ),
      ),
    );
  }
}
