import 'package:ecommerce_app/app/app_state.dart';
import 'package:ecommerce_app/src/common_widgets/component_button.dart';
import 'package:ecommerce_app/src/common_widgets/component_sized_box.dart';
import 'package:ecommerce_app/src/common_widgets/component_text_widgets.dart';
import 'package:ecommerce_app/src/constants/constants_colors.dart';
import 'package:ecommerce_app/src/features/products/presentation/products_list/products_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/order_response_model.dart';

class ThankyouScreen extends StatefulWidget {
  OrderResponseModel orderResponseModel;
  ThankyouScreen({ Key? key,required this.orderResponseModel})
      : super(key: key);

  @override
  State<ThankyouScreen> createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<ThankyouScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Order Received',
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
            ),
            ComponentSizedBox.topMargin(size: 30),
            ComponentText.buildTextWidget(
                title: 'Your order is complete.',fontSize: 18,fontWeight: FontWeight.bold),
                ComponentSizedBox.topMargin(size: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ComponentText.buildTextWidget(title: 'Thank you for the purchase. Your order have been received. Below are the order details. You will get an email with order details along with the tracking code.',maxLines: 4,textAlign: TextAlign.center),
                ),
                 ComponentSizedBox.topMargin(size: 16),
                ComponentText.buildTextWidget(
                title: 'Tracking Code : ${widget.orderResponseModel.data!.trackingNumber}',fontSize: 18 ,fontWeight: FontWeight.bold),
            ComponentSizedBox.topMargin(size: 40),
            ComponentButton.buildButton(onPressed: (){
               ApplicationState.instance.cartProducts ={};
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ProductsListScreen()),
                      (Route<dynamic> route) => route.isFirst);
            },title: 'Return to homepage'.toUpperCase())
            
           
          ],
        ),
      ),
    );
  }
}
