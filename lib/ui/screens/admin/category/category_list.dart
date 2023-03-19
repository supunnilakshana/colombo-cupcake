import 'package:cackeapp/config/initdata.dart';
import 'package:cackeapp/models/category_model.dart';
import 'package:cackeapp/services/firebase/fb_handeler.dart';
import 'package:cackeapp/ui/screens/admin/category/add_category.dart';
import 'package:cackeapp/ui/screens/admin/home/home_screen.dart';
import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:cackeapp/ui/widgets/category_card.dart';
import 'package:cackeapp/ui/widgets/errorpage.dart';
import 'package:cackeapp/ui/widgets/popup_dilog.dart';
import 'package:cackeapp/ui/widgets/tots.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  late Future<List<CategoryModel>> futureData;

  loadData() {
    futureData = FbHandeler.getCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Cake Categories"),
        leading: BackButton(
          color: kPrimaryColordark,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const HomeScreenAdmin();
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: kPrimaryColordark,
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreatCategoryScreen()));
          },
          label: const Text("Create a category"),
          icon: const Icon(Icons.add)),
      body: FutureBuilder(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CategoryModel> data = snapshot.data as List<CategoryModel>;
            print(data);
            if (data.isNotEmpty) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var itemData = data[index];
                  return CategoryCard(
                    no: (index + 1).toString(),
                    titel: itemData.name,
                    b1fun: () {
                      PopupDialog.showPopupWarning(
                          context, "Delete", "Are you sure to delete?",
                          () async {
                        final res = await FbHandeler.deletedoc(
                            CollectionPath.categorypath, itemData.id!);
                        if (res == resok) {
                          Customtost.commontost("Successfull", Colors.blue);
                        } else {
                          Customtost.commontost("Error", Colors.red);
                        }

                        loadData();
                        setState(() {});
                      });
                    },
                  );
                },
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
}
