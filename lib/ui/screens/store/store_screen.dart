import 'package:cackeapp/config/initdata.dart';
import 'package:cackeapp/models/category_model.dart';
import 'package:cackeapp/models/product_model.dart';
import 'package:cackeapp/services/firebase/fb_handeler.dart';
import 'package:cackeapp/ui/screens/admin/category/add_category.dart';
import 'package:cackeapp/ui/screens/admin/home/home_screen.dart';
import 'package:cackeapp/ui/screens/admin/products/addnew_producrs.dart';
import 'package:cackeapp/ui/screens/admin/products/edit_products.dart';
import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:cackeapp/ui/widgets/category_card.dart';
import 'package:cackeapp/ui/widgets/chips_widget.dart';
import 'package:cackeapp/ui/widgets/errorpage.dart';
import 'package:cackeapp/ui/widgets/item_card.dart';
import 'package:cackeapp/ui/widgets/popup_dilog.dart';
import 'package:cackeapp/ui/widgets/product_card.dart';
import 'package:cackeapp/ui/widgets/tots.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<ProductModel> filterdProducts = [];
  int categorySelection = 0;
  late Future<List<ProductModel>> futureData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Cake Store"),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CategoryModel> category =
                snapshot.data![0] as List<CategoryModel>;

            List<ProductModel> products =
                snapshot.data![1] as List<ProductModel>;

            if (category.isNotEmpty && products.isNotEmpty) {
              if (categorySelection == 0) {
                filterdProducts = products;
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: List.generate(category.length, (index) {
                          final item = category[index];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CategoryChip(
                              lable: item.name,
                              isSelected: categorySelection == index,
                              statuschange: () {
                                categorySelection = index;

                                print(products.length);
                                if (categorySelection != 0) {
                                  filterdProducts = products
                                      .where((element) =>
                                          element.category.id == item.id)
                                      .toList();
                                } else {
                                  filterdProducts = products;
                                }
                                setState(() {});
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  filterdProducts.isNotEmpty
                      ? Expanded(
                          child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children:
                              List.generate(filterdProducts.length, (index) {
                            final item = filterdProducts[index];
                            return ItemCard(pmodel: item);
                          }),
                        ))
                      : Center(
                          child: Lottie.asset("assets/animations/emptybox.json",
                              width: size.width * 0.6)),
                ],
              );
            } else {
              return Center(
                  child: Lottie.asset("assets/animations/emptybox.json",
                      width: size.width * 0.6));
            }
          } else if (snapshot.hasError) {
            return Errorpage(size: size.width * 0.7);
          }

          return Center(child: getLoadinganimi(size));
        },
      ),
    );
  }

  Future<List<dynamic>> fetchData() async {
    Future<List<CategoryModel>> fCategory = FbHandeler.getCategorieswithAll();
    Future<List<ProductModel>> fProducts = FbHandeler.getProducts();

    var results = await Future.wait([fCategory, fProducts]);
    return results;
  }
}
