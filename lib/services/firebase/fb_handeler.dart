import 'package:cackeapp/config/initdata.dart';
import 'package:cackeapp/models/category_model.dart';
import 'package:cackeapp/models/order_model.dart';
import 'package:cackeapp/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../models/usermodel.dart';

class FbHandeler {
  static final user = FirebaseAuth.instance.currentUser;
  static final firestoreInstance = FirebaseFirestore.instance;
  static final DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  static const String chatboxpath = "chatbox";

//check doc is exists
  static Future<int> checkdocstatus(String collectionpath, String docid) async {
    var a = await FirebaseFirestore.instance
        .collection(collectionpath)
        .doc(docid)
        .get();
    if (a.exists) {
      return 1;
    } else if (!a.exists) {
      print('Not exists');
      return 0;
    } else {
      return 0;
    }
  }

// create doc random id;
  static Future<int> createDocAuto(
      Map<String, dynamic> model, String collectionpath) async {
    int res = resfail;
    try {
      await firestoreInstance
          .collection(collectionpath)
          .doc()
          .set(model)
          .then((_) {
        print("create  doc");
        res = resok;
      });
    } on Exception catch (e) {
      print(e);
      res = resfail;
    }

    return res;
  }

  // create doc manual id;
  static Future<int> createDocManual(
      Map<String, dynamic> model, String collectionpath, String docid) async {
    int res = resfail;
    try {
      await firestoreInstance
          .collection(collectionpath)
          .doc(docid)
          .set(model)
          .then((_) {
        print("create  doc");
        res = resok;
      });
    } on Exception catch (e) {
      print(e);
      res = resfail;
    }

    return res;
  }

//update doc
  static Future<int> updateDoc(
      Map<String, dynamic> model, String collectionpath, String docid) async {
    int res = resfail;
    try {
      await firestoreInstance
          .collection(collectionpath)
          .doc(docid)
          .update(model)
          .then((_) {
        print("update doc");
        res = resok;
      });
    } on Exception catch (e) {
      print(e);
      res = resfail;
    }
    return res;
  }

  //delete doc
  static Future<int> deletedoc(String collection, String docid) async {
    int res = resfail;
    try {
      await firestoreInstance.collection(collection).doc(docid).delete();
      print("delete doc");
      res = resok;
    } on Exception catch (e) {
      print(e);
      res = resfail;
    }
    return res;
  }

//get user details

  static Future<UserModel> getUser() async {
    String uid = user!.uid.toString();
    const String collectionpath = "/users/";
    UserModel model;

    DocumentSnapshot documentSnapshot =
        await firestoreInstance.collection(collectionpath).doc(uid).get();
    model = UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    return model;
  }

  static Future<UserModel> getUserid(String id) async {
    String uid = id;
    const String collectionpath = "/users/";
    UserModel model;

    DocumentSnapshot documentSnapshot =
        await firestoreInstance.collection(collectionpath).doc(uid).get();
    model = UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    return model;
  }

  //cat
  static Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> enlist = [];
    CategoryModel enmodel;
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(CollectionPath.categorypath).get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      print(a.data());
      enmodel = CategoryModel.fromMap(a.data() as Map<String, dynamic>, a.id);
      enlist.add(enmodel);
      print("passed");
    }
    print(enlist);
    enlist.sort((a, b) => b.name.compareTo(a.name));
    return enlist;
  }

  static Future<List<CategoryModel>> getCategorieswithAll() async {
    List<CategoryModel> enlist = [];
    CategoryModel enmodel;
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(CollectionPath.categorypath).get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];

      enmodel = CategoryModel.fromMap(a.data() as Map<String, dynamic>, a.id);
      enlist.add(enmodel);
    }

    enlist.sort((a, b) => b.name.compareTo(a.name));
    enlist.insert(0, defCategory);
    return enlist;
  }

  static Future<List<ProductModel>> getProducts() async {
    List<ProductModel> enlist = [];
    ProductModel enmodel;
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(CollectionPath.productpath).get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      print(a.data());
      enmodel = ProductModel.fromMap(a.data() as Map<String, dynamic>, a.id);
      enlist.add(enmodel);
      print("passed");
    }
    print(enlist);
    enlist.sort((a, b) => b.name.compareTo(a.name));
    return enlist;
  }

  static Future<List<OrderModel>> getOrders() async {
    List<OrderModel> enlist = [];
    OrderModel enmodel;
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(CollectionPath.orderPath).get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      print(a.data());
      enmodel = OrderModel.fromMap(a.data() as Map<String, dynamic>, a.id);
      enlist.add(enmodel);
      print("passed");
    }
    print(enlist);
    enlist.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return enlist;
  }

  static Future<List<OrderModel>> getMyOrders() async {
    final user = FirebaseAuth.instance.currentUser;
    List<OrderModel> enlist = [];
    OrderModel enmodel;
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection(CollectionPath.orderPath)
        .where("customerID", isEqualTo: user!.uid)
        .get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      print(a.data());
      enmodel = OrderModel.fromMap(a.data() as Map<String, dynamic>, a.id);
      enlist.add(enmodel);
      print("passed");
    }
    print(enlist);
    enlist.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return enlist;
  }

//realtimedb
  static Future<int> checkfiledstatus(String collectionpath) async {
    final snapshot = await dbRef.child('$collectionpath').get();
    if (snapshot.exists) {
      return 0;
    } else {
      return 1;
    }
  }
}
