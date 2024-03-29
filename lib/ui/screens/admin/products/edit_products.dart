import 'dart:io';
import 'dart:typed_data';
import 'package:cackeapp/config/initdata.dart';
import 'package:cackeapp/models/category_model.dart';
import 'package:cackeapp/models/product_model.dart';
import 'package:cackeapp/services/date_time/date.dart';
import 'package:cackeapp/services/firebase/fb_handeler.dart';
import 'package:cackeapp/services/upload/file_upload.dart';
import 'package:cackeapp/services/validator/validate_handeler.dart';
import 'package:cackeapp/ui/screens/admin/products/product_list.dart';
import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:cackeapp/ui/widgets/chips_widget.dart';
import 'package:cackeapp/ui/widgets/errorpage.dart';
import 'package:cackeapp/ui/widgets/popup_dilog.dart';
import 'package:cackeapp/ui/widgets/tots.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel pmode;
  const EditProductScreen({Key? key, required this.pmode}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  String _price = "";
  String _desc = "";
  String _mobile = "";
  String _titel = "";
  String _description = "";
  int categorySelection = -1;
  CategoryModel? category;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titelcon = TextEditingController();
  final TextEditingController _pricecon = TextEditingController();

  final TextEditingController _descriptioncon = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  late Future<List<CategoryModel>> futureData;
  bool isfirst = true;
  loadData() {
    futureData = FbHandeler.getCategories();
    _titelcon.text = widget.pmode.name;
    _descriptioncon.text = widget.pmode.context;
    _pricecon.text = widget.pmode.price.toStringAsFixed(2);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // _mobilecon.text = usermodel.snum;

    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: FutureBuilder(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CategoryModel> data = snapshot.data as List<CategoryModel>;
              print(data);

              if (data.isNotEmpty) {
                if (isfirst) {
                  categorySelection = data.indexWhere(
                    (element) => element.id == widget.pmode.category.id,
                  );
                  category = data[categorySelection];
                  isfirst = false;
                }

                return Form(
                  key: _formKey,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(gradient: kGradientbrown),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.02),
                        const BackButton(
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 2, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Edit your new product",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 32),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(height: size.height * 0.01),
                            ],
                          ),
                        ),
                        const SizedBox(height: 1),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(60),
                                    topRight: Radius.circular(60))),
                            child: SingleChildScrollView(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Select a catgoty"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 50,
                                        child: ListView(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: List.generate(data.length,
                                              (index) {
                                            final item = data[index];

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: CategoryChip(
                                                lable: item.name,
                                                isSelected:
                                                    categorySelection == index,
                                                statuschange: () {
                                                  category = item;
                                                  categorySelection = index;
                                                  setState(() {});
                                                },
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        isimgload
                                            ? SizedBox(
                                                width: size.width * 0.4,
                                                child: Image.file(
                                                    File(_image!.path)),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: size.width * 0.4,
                                                  child: GestureDetector(
                                                    child: Image.network(
                                                        widget.pmode.imageurl),
                                                    onTap: () async {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      _imgFromGallery();
                                                    },
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    84, 163, 92, 30),
                                                blurRadius: 20,
                                                offset: Offset(0, 10))
                                          ]),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors
                                                            .grey.shade200))),
                                            child: TextFormField(
                                              controller: _titelcon,
                                              onChanged: (value) {
                                                _titel = value;
                                              },
                                              validator: (value) {
                                                return Validater.genaralvalid(
                                                    value!);
                                              },
                                              decoration: const InputDecoration(
                                                  hintText: "Product Name",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors
                                                            .grey.shade200))),
                                            child: TextFormField(
                                              controller: _pricecon,
                                              onChanged: (value) {
                                                _price = value;
                                              },
                                              validator: (value) {
                                                return Validater.isNumeric(
                                                    value!);
                                              },
                                              decoration: const InputDecoration(
                                                  hintText: "Price",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors
                                                            .grey.shade200))),
                                            child: TextFormField(
                                              maxLines: 6,
                                              controller: _descriptioncon,
                                              onChanged: (value) {
                                                _description = value;
                                              },
                                              validator: (value) {
                                                return Validater.genaralvalid(
                                                    value!);
                                              },
                                              decoration: const InputDecoration(
                                                  hintText: "Description",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (_formKey.currentState!.validate() &&
                                            category != null) {
                                          PopupDialog.loading(context);
                                          String iurl = await _imageUpload();

                                          final pmodel = ProductModel(
                                              name: _titelcon.text,
                                              context: _descriptioncon.text,
                                              category: category!,
                                              imageurl: iurl,
                                              price: double.parse(
                                                  _pricecon.text.trim()),
                                              addeddate: DateTime.now());
                                          // ignore: use_build_context_synchronously

                                          int r = await FbHandeler.updateDoc(
                                              pmodel.toMap(),
                                              CollectionPath.productpath,
                                              widget.pmode.id!);

                                          if (r == resok) {
                                            //  ignore: use_build_context_synchronously
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return const ProductScreen();
                                                },
                                              ),
                                            );
                                            Customtost.commontost(
                                                "Succussfully updated",
                                                Colors.green);
                                          } else if (r == resfail) {
                                            // ignore: use_build_context_synchronously
                                            Navigator.pop(context);
                                            Get.snackbar(
                                              "Somthing went wromg",
                                              "Please try again",
                                              colorText: Colors.red,
                                              backgroundColor: Colors.yellow,
                                              icon: const Icon(Icons.error,
                                                  color: Colors.black),
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                            );
                                          }
                                        } else {
                                          print("Not Complete");
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 50),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: kPrimaryColordark),
                                        child: const Center(
                                          child: Text(
                                            "Update",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                Center(
                    child: Column(
                  children: [
                    Lottie.asset("assets/animations/emptybox.json",
                        width: size.width * 0.6),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("No categories available"),
                    )
                  ],
                ));
              }
            } else if (snapshot.hasError) {
              return Errorpage(size: size.width * 0.7);
            }

            return Center(child: getLoadinganimi(size));
          },
        ),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  bool isimgload = false;

  Future<void> _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      setState(() {
        _image = image;
        isimgload = true;
      });
    }
  }

  Future<String> _imageUpload() async {
    String imgurl = widget.pmode.imageurl;
    if (isimgload) {
      Uint8List imgunitfile = await _image!.readAsBytes();
      String imgid = Date.getDateTimeId();
      imgurl =
          await FileUploader.uploadImage(imgunitfile, postimagebucket, imgid);
    } else {
      imgurl = widget.pmode.imageurl;
    }
    return imgurl;
  }
}
