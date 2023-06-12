import 'package:ecommerce_app/src/common_widgets/component_sized_box.dart';
import 'package:ecommerce_app/src/common_widgets/component_text_widgets.dart';
import 'package:ecommerce_app/src/helpers/PrefManager.dart';
import 'package:ecommerce_app/src/models/order_history_model.dart';
import 'package:ecommerce_app/src/repositories/app_repo.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import 'constants/AppKeys.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  OrderHistoryModel? orderHistoryModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();
  }

  getOrders() async {
   String email =  await PrefManager().read(AppKeys.Email);
    orderHistoryModel = await AppRepo().apiGetOrders(email);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order history'),
      ),
      body: orderHistoryModel == null
          ? Container(
              margin: EdgeInsets.all(16),
            )
          : ListView.builder(itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ComponentText.buildTextWidget(
                          title:
                              'Order # ${orderHistoryModel!.data![index].consignmentNumber??'N/A'}',
                          fontWeight: FontWeight.bold),
                      ComponentSizedBox.topMargin(size: 6),
                      ComponentText.buildTextWidget(
                          title:
                              'Tracking Number # ${orderHistoryModel!.data![index].trackingNumber}',
                          fontWeight: FontWeight.bold),
                      ComponentSizedBox.topMargin(size: 6),
                      ComponentText.buildTextWidget(
                          title:
                              'Date # ${orderHistoryModel!.data![index].orderAt!}',
                          fontWeight: FontWeight.bold),
                      ComponentSizedBox.topMargin(size: 6),
                      ComponentText.buildTextWidget(
                          title:
                              'Status # ${orderHistoryModel!.data![index].status!}',
                          fontWeight: FontWeight.bold),
                      ComponentSizedBox.topMargin(size: 6),
                      ComponentText.buildTextWidget(
                          title:
                              'Total # ${orderHistoryModel!.data![index].total!}',
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
              );
            }),
    );
  }
}
