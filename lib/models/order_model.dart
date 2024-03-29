// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:cackeapp/models/cart_item_model.dart';

class OrderModel {
  final String? orderID;
  String customerID;
  String customerName;
  String customerMobile;
  String customerAddr;
  String customerEmail;
  List<CartItemModel> items;
  double total;
  bool iscomplete;
  DateTime createdAt;
  OrderModel({
    this.orderID,
    required this.customerID,
    required this.customerName,
    required this.customerMobile,
    required this.customerAddr,
    required this.customerEmail,
    required this.items,
    required this.total,
    required this.iscomplete,
    required this.createdAt,
  });

  OrderModel copyWith({
    String? orderID,
    String? customerID,
    String? customerName,
    String? customerMobile,
    String? customerAddr,
    String? customerEmail,
    List<CartItemModel>? items,
    double? total,
    bool? iscomplete,
    DateTime? createdAt,
  }) {
    return OrderModel(
      orderID: orderID ?? this.orderID,
      customerID: customerID ?? this.customerID,
      customerName: customerName ?? this.customerName,
      customerMobile: customerMobile ?? this.customerMobile,
      customerAddr: customerAddr ?? this.customerAddr,
      customerEmail: customerEmail ?? this.customerEmail,
      items: items ?? this.items,
      total: total ?? this.total,
      iscomplete: iscomplete ?? this.iscomplete,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderID': orderID,
      'customerID': customerID,
      'customerName': customerName,
      'customerMobile': customerMobile,
      'customerAddr': customerAddr,
      'customerEmail': customerEmail,
      'items': items.map((x) => x.toMap()).toList(),
      'total': total,
      'iscomplete': iscomplete,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map, String id) {
    return OrderModel(
      orderID: id,
      customerID: map['customerID'] as String,
      customerName: map['customerName'] as String,
      customerMobile: map['customerMobile'] as String,
      customerAddr: map['customerAddr'] as String,
      customerEmail: map['customerEmail'] as String,
      items: List<CartItemModel>.from(
        (map['items'] as List<dynamic>).map<CartItemModel>(
          (x) => CartItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      total: map['total'] as double,
      iscomplete: map['iscomplete'] as bool,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'OrderModel(orderID: $orderID, customerID: $customerID, customerName: $customerName, customerMobile: $customerMobile, customerAddr: $customerAddr, customerEmail: $customerEmail, items: $items, total: $total, iscomplete: $iscomplete, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.orderID == orderID &&
        other.customerID == customerID &&
        other.customerName == customerName &&
        other.customerMobile == customerMobile &&
        other.customerAddr == customerAddr &&
        other.customerEmail == customerEmail &&
        listEquals(other.items, items) &&
        other.total == total &&
        other.iscomplete == iscomplete &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return orderID.hashCode ^
        customerID.hashCode ^
        customerName.hashCode ^
        customerMobile.hashCode ^
        customerAddr.hashCode ^
        customerEmail.hashCode ^
        items.hashCode ^
        total.hashCode ^
        iscomplete.hashCode ^
        createdAt.hashCode;
  }
}
