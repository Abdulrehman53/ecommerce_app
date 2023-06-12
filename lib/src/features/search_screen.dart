import 'package:ecommerce_app/src/constants/constants_colors.dart';
import 'package:ecommerce_app/src/features/products/presentation/products_list/products_grid.dart';
import 'package:ecommerce_app/src/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../common_widgets/responsive_center.dart';
import '../constants/app_sizes.dart';
import '../repositories/app_repo.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();
  final _scrollController = ScrollController();
  String slug = '';
  ProductModel? productModel;
  searchProduct(String slug) async {
    productModel = ProductModel(data: ProductDatum(products: []));
    productModel = await AppRepo().searchProduct(slug);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        /*  InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                    ))), */
        title: Container(
          padding: EdgeInsets.only(left: 5),
          child: Theme(
            data: ThemeData(
              primaryColor: Colors.white,
              hintColor: Colors.white,
            ),
            child: TextField(
              style: TextStyle(color: Colors.black),
              controller: _controller,
              onSubmitted: (value) {
                if (value.length > 0) {}
              },
              onChanged: (value) {
                setState(() {
                  slug = value;
                });
              },
              autofocus: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.black,
                  hintText: 'Search',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18)),
            ),
          ),
        ),
        actions: <Widget>[
          Visibility(
            visible: slug != null && slug.isNotEmpty,
            child: IconButton(
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
              onPressed: () {
                _controller.clear();
                setState(() {
                  slug = '';
                });
              },
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              // if (slug.length > 0)
              if (_controller.text.length > 0) searchProduct(_controller.text);
              FocusScope.of(context).requestFocus(new FocusNode());
            },
          ),
        ],
      ),
      body: productModel == null
          ? Container()
          : CustomScrollView(
              controller: _scrollController,
              slivers: [
                /*   ResponsiveSliverCenter(
                    padding: EdgeInsets.all(Sizes.p16),
                    child: ProductsSearchTextField(),
                  ), */
                ResponsiveSliverCenter(
                  padding: EdgeInsets.all(Sizes.p16),
                  child: ProductsGrid(
                    callback: () {
                      print('Hello');
                      setState(() {});
                    },
                    product: productModel!,
                  ),
                ),
              ],
            ),
    );
  }
}
