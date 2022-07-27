import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'sales_customers_items_model.dart';

class SalesCustomersModel {
  final int? customerCode;
  final List<SalesCustomersItemsModel>? salesCustomers;
  SalesCustomersModel({
    this.customerCode,
    this.salesCustomers,
  });

  SalesCustomersModel copyWith({
    int? customerCode,
    List<SalesCustomersItemsModel>? salesCustomers,
  }) {
    return SalesCustomersModel(
      customerCode: customerCode ?? this.customerCode,
      salesCustomers: salesCustomers ?? this.salesCustomers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerCode': customerCode,
      'salesCustomers': salesCustomers?.map((x) => x.toMap()).toList(),
    };
  }

  factory SalesCustomersModel.fromMap(Map<String, dynamic> map) {
    return SalesCustomersModel(
      customerCode: map['customerCode']?.toInt(),
      salesCustomers: map['salesCustomers'] != null
          ? List<SalesCustomersItemsModel>.from(map['salesCustomers']
              ?.map((x) => SalesCustomersItemsModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesCustomersModel.fromJson(Map<String, dynamic> json) {
    return SalesCustomersModel(
      customerCode: json['customerCode']?.toInt() ?? 0,
      salesCustomers: json['salesCustomers'] != null
          ? List<SalesCustomersItemsModel>.from(json['salesCustomers']
              ?.map((x) => SalesCustomersItemsModel.fromMap(x)))
          : [],
    );
  }

  @override
  String toString() =>
      'SalesCustomersModel(customerCode: $customerCode, salesCustomers: $salesCustomers)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SalesCustomersModel &&
        other.customerCode == customerCode &&
        listEquals(other.salesCustomers, salesCustomers);
  }

  @override
  int get hashCode => customerCode.hashCode ^ salesCustomers.hashCode;
}
