import 'package:ecommerce_app/src/models/single_product_model.dart';

import '../src/models/product_model.dart';

class ApplicationState {
  static final ApplicationState instance = ApplicationState._internal();

  ApplicationState._privateConstructor();

  static final ApplicationState _instance =
      ApplicationState._privateConstructor();

  factory ApplicationState() {
    return _instance;
  }
  Set<SingleProduct> cartProducts = {};
  ApplicationState._internal();
}
