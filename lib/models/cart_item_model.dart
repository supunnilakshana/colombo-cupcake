import 'dart:convert';

import 'package:cackeapp/models/product_model.dart';

class CartItemModel {
  final String id;
  final ProductModel item;
  int qty;
  CartItemModel({
    required this.id,
    required this.item,
    required this.qty,
  });

  CartItemModel copyWith({
    String? id,
    ProductModel? item,
    int? qty,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      item: item ?? this.item,
      qty: qty ?? this.qty,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'item': item.toMap(),
      'qty': qty,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] as String,
      item: ProductModel.fromMapsub(map['item'] as Map<String, dynamic>),
      qty: map['qty'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CartItemModel(id: $id, item: $item, qty: $qty)';

  @override
  bool operator ==(covariant CartItemModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.item == item && other.qty == qty;
  }

  @override
  int get hashCode => id.hashCode ^ item.hashCode ^ qty.hashCode;
}
