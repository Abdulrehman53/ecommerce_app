import 'dart:convert';

import 'package:ecommerce_app/config/router.dart';
import 'package:ecommerce_app/src/constants/AppKeys.dart';
import 'package:ecommerce_app/src/helpers/PrefManager.dart';
import 'package:ecommerce_app/src/models/banners_model.dart';
import 'package:ecommerce_app/src/models/base_model.dart';
import 'package:ecommerce_app/src/models/categories_model.dart';
import 'package:ecommerce_app/src/models/city_model.dart';
import 'package:ecommerce_app/src/models/order_response_model.dart';
import 'package:ecommerce_app/src/models/place_order_model.dart';
import 'package:ecommerce_app/src/models/product_model.dart';
import 'package:ecommerce_app/src/models/single_product_model.dart';
import 'package:ecommerce_app/src/models/token_model.dart';
import 'package:ecommerce_app/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../features/products/presentation/products_list/products_list_screen.dart';
import '../models/order_history_model.dart';
import '../models/register_model.dart';
import 'package:dio/dio.dart' as dio;

import '../networking/networking_managar.dart';

class AppRepo {
  Future signup(
      {required RegisterModel? registerModel,
      required BuildContext context}) async {
    //dio.FormData? formData;

    Map<String, dynamic> formData = {
      'email': registerModel?.email,
      'password': registerModel?.password,
      'confirm_password': registerModel?.password,
      'name': registerModel?.name,
    };

    dio.Response? response = await NetworkManager().callApi(
        method: HttpMethod.Post,
        urlEndPoint: AppKeys.Registration,
        body: json.encode(formData),
        isFormDataRequest: false);

    Fluttertoast.showToast(msg: 'User Created Successfully');
    Navigator.pop(context);
    //InvoiceModel invoiceModel = InvoiceModel.fromMap(response!.data);

    // if (response.statusCode == ConstantsNums.API_CODE_SUCCESS) {
    return null;
  }

  Future<ProductModel> getProductsApi() async {
    //dio.FormData? formData;

    dio.Response? response = await NetworkManager().callApi(
        method: HttpMethod.Get,
        urlEndPoint: AppKeys.GetProducts,
        isFormDataRequest: false);

    //InvoiceModel invoiceModel = InvoiceModel.fromMap(response!.data);

    // if (response.statusCode == ConstantsNums.API_CODE_SUCCESS) {
    return ProductModel.fromMap(response!.data);
  }

  Future<CategoriesModel> getCategoriesApi() async {
    //dio.FormData? formData;

    dio.Response? response = await NetworkManager().callApi(
        method: HttpMethod.Get,
        urlEndPoint: AppKeys.GetCategories,
        isFormDataRequest: false);

    //InvoiceModel invoiceModel = InvoiceModel.fromMap(response!.data);

    // if (response.statusCode == ConstantsNums.API_CODE_SUCCESS) {
    return CategoriesModel.fromMap(response!.data);
  }
  Future<BannersModel> getBannersApi() async {
    //dio.FormData? formData;

    dio.Response? response = await NetworkManager().callApi(
        method: HttpMethod.Get,
        urlEndPoint: 'get-site-banners',
        isFormDataRequest: false);

    //InvoiceModel invoiceModel = InvoiceModel.fromMap(response!.data);

    // if (response.statusCode == ConstantsNums.API_CODE_SUCCESS) {
    return BannersModel.fromMap(response!.data);
  }

  Future<ProductModel> getCategoriesProductsApi(String? catId) async {
    //dio.FormData? formData;

    dio.Response? response = await NetworkManager().callApi(
        method: HttpMethod.Get,
        urlEndPoint: 'get-products?main_category=$catId&limit=10&page=1',
        isFormDataRequest: false);

    //InvoiceModel invoiceModel = InvoiceModel.fromMap(response!.data);

    // if (response.statusCode == ConstantsNums.API_CODE_SUCCESS) {
    return ProductModel.fromMap(response!.data);
  }

  Future<SingleProduct> getProduct(String? productId) async {
    //dio.FormData? formData;

    dio.Response? response = await NetworkManager().callApi(
        method: HttpMethod.Get,
        urlEndPoint: 'get-single-product?id=$productId',
        isFormDataRequest: false);

    //InvoiceModel invoiceModel = InvoiceModel.fromMap(response!.data);

    // if (response.statusCode == ConstantsNums.API_CODE_SUCCESS) {
    return SingleProduct.fromMap(response!.data);
  }

  Future<ProductModel> searchProduct(String slug) async {
    //dio.FormData? formData;

    dio.Response? response = await NetworkManager().callApi(
        method: HttpMethod.Get,
        urlEndPoint: 'search-product?search=$slug&page=2',
        isFormDataRequest: false);

    //InvoiceModel invoiceModel = InvoiceModel.fromMap(response!.data);

    // if (response.statusCode == ConstantsNums.API_CODE_SUCCESS) {
    return ProductModel.fromMap(response!.data);
  }

  Future<void> deleteUser() async {
    //dio.FormData? formData;
    String email = await PrefManager().read(AppKeys.Email);
    var params = {'email': email};
    dio.Response? response = await NetworkManager().callApi(
        method: HttpMethod.Post,
        urlEndPoint: 'delete-user',
        body: json.encode(params),
        isFormDataRequest: false);

    //InvoiceModel invoiceModel = InvoiceModel.fromMap(response!.data);

    // if (response.statusCode == ConstantsNums.API_CODE_SUCCESS) {
    return null;
  }

  Future<OrderResponseModel> apiPlaceOrder(
      PlaceOrderModel placeOrderModel) async {
    //dio.FormData? formData;

    dio.Response? response = await NetworkManager().callApi(
        method: HttpMethod.Post,
        urlEndPoint: 'place-order',
        body: placeOrderModel.toJson(),
        isFormDataRequest: false);

    //InvoiceModel invoiceModel = InvoiceModel.fromMap(response!.data);

    // if (response.statusCode == ConstantsNums.API_CODE_SUCCESS) {
    return OrderResponseModel.fromMap(response!.data);
  }

  Future<String?> getToken() async {
    //dio.FormData? formData;
    var formData = dio.FormData.fromMap({
      'email': 'app@keunepakistan.com',
      'password': 'test@123',
    });
    dio.Response? response = await NetworkManager().callApi(
        method: HttpMethod.Post, urlEndPoint: 'token', isFormDataRequest: true,formData: formData);

    //InvoiceModel invoiceModel = InvoiceModel.fromMap(response!.data);

    // if (response.statusCode == ConstantsNums.API_CODE_SUCCESS) {
    return TokenModel.fromMap(response!.data).data!.token;
  }

  Future<CityModel> apiGetCities() async {
    //dio.FormData? formData;

    dio.Response? response = await NetworkManager().callApi(
        method: HttpMethod.Get,
        urlEndPoint: 'get-cities',
        isFormDataRequest: false);

    //InvoiceModel invoiceModel = InvoiceModel.fromMap(response!.data);

    return CityModel.fromMap(response!.data);
  }

  Future<OrderHistoryModel> apiGetOrders(String email) async {
    //dio.FormData? formData;

    var params = {'email': email};

    dio.Response? response = await NetworkManager().callApi(
        method: HttpMethod.Post,
        urlEndPoint: 'get-orders',
        body: json.encode(params),
        isFormDataRequest: false);

    //InvoiceModel invoiceModel = InvoiceModel.fromMap(response!.data);

    return OrderHistoryModel.fromMap(response!.data);
  }

  Future login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    //dio.FormData? formData;

    Map<String, dynamic> formData = {
      'email': email,
      'password': password,
    };

    dio.Response? response = await NetworkManager().callApi(
        method: HttpMethod.Post,
        urlEndPoint: AppKeys.Login,
        body: json.encode(formData),
        isFormDataRequest: false);
    PrefManager prefManager = PrefManager();
    UserModel userModel = UserModel.fromMap(response!.data);
    prefManager.save(AppKeys.Email, userModel.data!.email);
    prefManager.save(AppKeys.Id, userModel.data!.id);
    prefManager.save(AppKeys.UserName, userModel.data!.fullName);
    // ignore: use_build_context_synchronously
    AppRouter.goToNextScreen(context, ProductsListScreen());
    //  Navigator.pop(context);
    //InvoiceModel invoiceModel = InvoiceModel.fromMap(response!.data);

    // if (response.statusCode == ConstantsNums.API_CODE_SUCCESS) {
    return null;
  }
}
