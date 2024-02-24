import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:ecommerce_app/config/router.dart';
import 'package:ecommerce_app/src/common_widgets/component_sized_box.dart';
import 'package:ecommerce_app/src/common_widgets/component_text_widgets.dart';
import 'package:ecommerce_app/src/features/products/presentation/home_app_bar/home_app_bar.dart';
import 'package:ecommerce_app/src/features/products/presentation/products_list/products_grid.dart';
import 'package:ecommerce_app/src/features/products/presentation/products_list/products_search_text_field.dart';
import 'package:ecommerce_app/src/features/search_screen.dart';
import 'package:ecommerce_app/src/models/banners_model.dart';
import 'package:ecommerce_app/src/models/categories_model.dart';
import 'package:ecommerce_app/src/models/schedule_model.dart';
import 'package:ecommerce_app/src/my_orders_screen.dart';
import 'package:ecommerce_app/src/repositories/app_repo.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/common_widgets/responsive_center.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../app/app_state.dart';
import '../../../../constants/AppKeys.dart';
import '../../../../constants/constants_colors.dart';
import '../../../../helpers/PrefManager.dart';
import '../../../../models/laywer_model.dart';
import '../../../../models/product_model.dart';
import '../../../authentication/auth/login_screen.dart';
import '../../../cart/presentation/shopping_cart/shopping_cart_screen.dart';
import '../home_app_bar/shopping_cart_icon.dart';

/// Shows the list of products with a search field at the top.
class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen>
    with SingleTickerProviderStateMixin {
  // * Use a [ScrollController] to register a listener that dismisses the
  // * on-screen keyboard when the user scrolls.
  // * This is needed because this page has a search field that the user can
  // * type into.
  final _scrollController = ScrollController();
  final CarouselController _carosoulcontroller = CarouselController();
  ProductModel? productModel;
  CategoriesModel? categoriesModel = CategoriesModel(data: []);
  BannersModel? bannersModel = BannersModel(data: []);
  late TabController _tabController;
  String? name;
  var json = """

{
  "records": {
    "id": 7,
    "name": "Muzamil Adv",
    "email": "muzamil@yopmail.com",
    "email_verified_at": null,
    "created_at": "Sep 2022",
    "updated_at": "2022-09-27T08:02:15.000000Z",
    "first_name": "Muzamil",
    "last_name": "Adv",
    "mobile": "9230000005445",
    "is_phone_verified": 0,
    "is_email_verified": 1,
    "verification_phone_code": null,
    "verification_email_code": null,
    "roles": [
      {
        "id": 3,
        "name": "Lawyer",
        "alias": "lawyer",
        "pivot": {
          "user_id": 7,
          "role_id": 3
        }
      }
    ],
    "categories": [
      {
        "id": 16,
        "user_id": 7,
        "category_id": 10,
        "created_at": null,
        "updated_at": null,
        "category": {
          "id": 10,
          "name": "Anti Terrorist",
          "is_active": 1,
          "created_at": null,
          "updated_at": null,
          "parent_category_id": null
        }
      },
      {
        "id": 17,
        "user_id": 7,
        "category_id": 11,
        "created_at": null,
        "updated_at": null,
        "category": {
          "id": 11,
          "name": "NAB",
          "is_active": 1,
          "created_at": null,
          "updated_at": null,
          "parent_category_id": null
        }
      }
    ],
    "schedule_timings": {
      "Sunday": [
        {
          "day_id": 1,
          "from_time": "12:00 am",
          "to_time": "12:30 am"
        }
      ],
      "Wednesday": [
        {
          "day_id": 4,
          "from_time": "03:30 am",
          "to_time": "06:30 am"
        },
        {
          "day_id": 4,
          "from_time": "06:30 am",
          "to_time": "07:00 am"
        },
        {
          "day_id": 4,
          "from_time": "11:00 am",
          "to_time": "12:30 pm"
        },
        {
          "day_id": 4,
          "from_time": "11:00 pm",
          "to_time": "11:30 pm"
        }
      ],
      "Saturday": [
        {
          "day_id": 7,
          "from_time": "12:00 am",
          "to_time": "12:30 am"
        },
        {
          "day_id": 7,
          "from_time": "01:30 am",
          "to_time": "03:30 am"
        },
        {
          "day_id": 7,
          "from_time": "03:30 am",
          "to_time": "05:00 am"
        },
        {
          "day_id": 7,
          "from_time": "06:30 am",
          "to_time": "07:30 am"
        }
      ]
    },
    "profile": {
      "id": 2,
      "user_id": 7,
      "country_id": 1,
      "province_id": 1,
      "city_id": 3,
      "bar_registration_city": "Lahore",
      "bar_registration_no": "465464",
      "bar_registration_doc": "1664266907-Water 340.jpeg",
      "nic": "11321346546546545",
      "nic_doc": "1664266907-Water 340.jpeg",
      "about": "jasGKSKSGASKASGJSSGJHS",
      "block": "1212",
      "office_no": "45454",
      "address": "lAKE cIRT",
      "postal_code": "465464",
      "degree": "phd",
      "degree_doc": "1664266907-Water 340.jpeg",
      "profile_img": "1664266907-ADV2.jfif",
      "title": null,
      "created_at": "2022-09-27T08:21:47.000000Z",
      "updated_at": "2022-10-03T12:27:46.000000Z",
      "country": {
        "id": 1,
        "name": "Pakistan",
        "code": "PKR",
        "created_at": "2022-09-27T07:04:52.000000Z",
        "updated_at": "2022-09-27T07:04:52.000000Z"
      },
      "province": {
        "id": 1,
        "country_id": 1,
        "name": "Punjab",
        "created_at": "2022-09-27T07:04:52.000000Z",
        "updated_at": "2022-09-27T07:04:52.000000Z"
      },
      "city": {
        "id": 3,
        "province_id": 1,
        "name": "Sialkot",
        "created_at": "2022-09-27T07:04:52.000000Z",
        "updated_at": "2022-09-27T07:04:52.000000Z"
      }
    },
    "languages": [
      {
        "id": 19,
        "user_id": 7,
        "language_id": 1,
        "language": {
          "id": 1,
          "name": "English"
        }
      },
      {
        "id": 20,
        "user_id": 7,
        "language_id": 3,
        "language": {
          "id": 3,
          "name": "Punjabi"
        }
      },
      {
        "id": 21,
        "user_id": 7,
        "language_id": 4,
        "language": {
          "id": 4,
          "name": "Pashto"
        }
      }
    ],
    "districts": [
      {
        "id": 9,
        "user_id": 7,
        "district_id": 1,
        "district": {
          "id": 1,
          "division_id": 1,
          "name": "Lahore District",
          "created_at": "2022-09-27T07:04:52.000000Z",
          "updated_at": "2022-09-27T07:04:52.000000Z"
        }
      }
    ],
    "queries": {
      "upcoming": 6,
      "completed": 0,
      "curr_month": 19,
      "all": 23
    }
  },
  "message": "Information fetched successfully"
}
  """;
  String? userId;
  String? guest;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
    getProducts();
    getUser();
  }

  getUser() async {
    userId = await PrefManager().read(AppKeys.Id);
    guest = await PrefManager().read(AppKeys.guest);
    setState(() {});
  }

  getProducts() async {
    name = await PrefManager().read(AppKeys.UserName);
    setState(() {});
    // String? token = await AppRepo().getToken();
    //await PrefManager().save(AppKeys.token, token);
    categoriesModel = await AppRepo().getCategoriesApi();
    getBanners();
    _tabController =
        TabController(length: categoriesModel!.data!.length, vsync: this);

    productModel =
        await AppRepo().getCategoriesProductsApi(categoriesModel!.data![0].id);
    setState(() {});
  }

  getBanners() async {
    setState(() {});
    //String? token = await AppRepo().getToken();
    // await PrefManager().save(AppKeys.token, token);
    bannersModel = await AppRepo().getBannersApi();
    setState(() {});
  }

  getProuductsById(String? catId) async {
    productModel = ProductModel(data: ProductDatum(products: []));
    productModel = await AppRepo().getCategoriesProductsApi(catId);
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    super.dispose();
  }

  // When the search text field gets the focus, the keyboard appears on mobile.
  // This method is used to dismiss the keyboard when the user scrolls.
  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  TextEditingController _controller = TextEditingController();
  String slug = '';

  static const shoppingCartIconKey = Key('shopping-cart');
  Function? callback;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () async {
        await AppRepo().deleteUser();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Account"),
      content: Text("Are you sure you want to delete?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Color(0xff151515),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff151515),
              ),
              child: CircleAvatar(
                child: Text(name ?? ''),
              ),
            ),
            ListTile(
              title: Text(
                'Home'.toUpperCase(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);

                // Update the state of the app.
                // ...
              },
            ),
            Divider(
              color: Colors.white,
            ),
            Container(
              child: ExpansionTile(
                title: Text(
                  'Products'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                children: categoriesModel!.data!
                    .map((data) => InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            getProuductsById(data.id);
                            var index = categoriesModel!.data!.indexOf(data);
                            _tabController.animateTo(index);
                          },
                          child: Container(
                            color: ConstantColor.APP_COLOR,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, bottom: 16, top: 8),
                              child: Text(
                                data.name!,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),

            /*  Divider(
              color: Colors.white,
            ),
            ListTile(
              title: Text(
                'Products'.toUpperCase(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ), */
            Divider(
              color: Colors.white,
            ),
            ListTile(
              title: Text(
                'Order History'.toUpperCase(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
                AppRouter.goToNextScreen(context, MyOrdersScreen());
              },
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              title: Text('Trends'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
              onTap: () {
                // Update the state of the app.
                // ...
                _launchUrl('https://www.keunepakistan.com/store/trends');
              },
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              title: Text('Star Users'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
              onTap: () {
                // Update the state of the app.
                // ...
                _launchUrl('https://www.keunepakistan.com/store/stars');
              },
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              title: Text('Videos'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
              onTap: () {
                // Update the state of the app.
                // ...
                _launchUrl(
                    'https://www.keunepakistan.com/store/videos/categories');
              },
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              title: Text('About Us'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
              onTap: () {
                // Update the state of the app.
                // ...
                _launchUrl('https://www.keunepakistan.com/store/about');
              },
            ),
            Divider(
              color: Colors.white,
            ),
            (userId != null && userId!.isNotEmpty)
                ? ListTile(
                    title: Text(
                      'Delete Account'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      showAlertDialog(context);
                    },
                  )
                : Container(),
            (userId != null && userId!.isNotEmpty)
                ? Divider(
                    color: Colors.white,
                  )
                : Container(),
            (userId != null && userId!.isNotEmpty ||
                    (guest != null && guest!.isNotEmpty))
                ? ListTile(
                    title: Text(
                      'Logout'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () async {
                      PrefManager().save(AppKeys.Email, '');
                      PrefManager().save(AppKeys.Id, '');
                      PrefManager().save(AppKeys.UserName, '');
                      PrefManager().save(AppKeys.guest, '');
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (Route<dynamic> route) => false);
                    },
                  )
                : Container(),
          ],
        ),
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    icon: Icon(Icons.dehaze)),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    AppRouter.goToNextScreen(context, SearchScreen());
                  },
                  child: Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.search, color: Colors.grey),
                          ComponentSizedBox.sideMargin(size: 4),
                          ComponentText.buildTextWidget(
                              title: 'Search', color: Colors.grey)
                        ],
                      ),
                    ),
                    height: 36,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey)),
                  ),
                )),
                Stack(
                  children: [
                    Center(
                      child: IconButton(
                        key: shoppingCartIconKey,
                        icon: Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.black.withOpacity(0.6),
                        ),
                        onPressed: () {
                          AppRouter.goToNextScreen(
                              context, ShoppingCartScreen());
                        },
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: ShoppingCartIconBadge(
                          itemsCount:
                              ApplicationState.instance.cartProducts.length),
                    ),
                  ],
                )
              ],
            ),
            productModel == null
                ? Container()
                : Expanded(
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          onTap: (index) {
                            getProuductsById(categoriesModel!.data![index].id);
                          },
                          unselectedLabelColor: Colors.grey,
                          labelColor: Colors.black,
                          tabs: categoriesModel!.data!
                              .map((data) => Tab(
                                    text: data.name,
                                  ))
                              .toList() /*  [
                        Tab(
                          text: 'All',
                        ),
                        Tab(
                          text: 'New Arrivals',
                        ),
                      ] */
                          ,
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: CustomScrollView(
                            controller: _scrollController,
                            slivers: [
                             /*  bannersModel == null
                                  ? Container()
                                  : */ SliverToBoxAdapter(child: carosolWidget()),
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
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget carosolWidget() {
    return bannersModel!.data!.length == 0
        ? SizedBox()
        : CarouselSlider(
            carouselController: _carosoulcontroller,
            items: bannersModel!.data!.map((imgurl) {
              return Builder(builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  //margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Image.network(
                    imgurl.image!,
                    fit: BoxFit.fill,
                  ),
                );
              });
            }).toList(),
            options: CarouselOptions(
              height: 140,
              viewportFraction: 0.8,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              onPageChanged: (index, reason) {},
            ),
          );
  }
}
