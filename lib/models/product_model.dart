import 'dart:convert';
import 'package:cackeapp/models/category_model.dart';

class ProductModel {
  final String? id;
  final String name;
  final String context;
  final CategoryModel category;
  final String imageurl;
  final double price;
  final DateTime addeddate;
  ProductModel({
    this.id,
    required this.name,
    required this.context,
    required this.category,
    required this.imageurl,
    required this.price,
    required this.addeddate,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? context,
    CategoryModel? category,
    String? imageurl,
    double? price,
    DateTime? addeddate,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      context: context ?? this.context,
      category: category ?? this.category,
      imageurl: imageurl ?? this.imageurl,
      price: price ?? this.price,
      addeddate: addeddate ?? this.addeddate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'context': context,
      'category': category.toMap(),
      'imageurl': imageurl,
      'price': price,
      'addeddate': addeddate.millisecondsSinceEpoch,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      context: map['context'] as String,
      category:
          CategoryModel.fromMapsub(map['category'] as Map<String, dynamic>),
      imageurl: map['imageurl'] as String,
      price: map['price'] as double,
      addeddate: DateTime.fromMillisecondsSinceEpoch(map['addeddate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, context: $context, category: $category, imageurl: $imageurl, price: $price, addeddate: $addeddate)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.context == context &&
        other.category == category &&
        other.imageurl == imageurl &&
        other.price == price &&
        other.addeddate == addeddate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        context.hashCode ^
        category.hashCode ^
        imageurl.hashCode ^
        price.hashCode ^
        addeddate.hashCode;
  }
}
