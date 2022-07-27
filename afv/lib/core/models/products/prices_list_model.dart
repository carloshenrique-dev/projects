import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:up_afv/core/models/products/prices_model.dart';

class PricesListModel {
  final int? productCode;
  final String? unit;
  final List<PricesModel> prices;
  PricesListModel({
    this.productCode,
    this.unit,
    required this.prices,
  });

  PricesListModel copyWith({
    int? productCode,
    String? unit,
    List<PricesModel>? prices,
  }) {
    return PricesListModel(
      productCode: productCode ?? this.productCode,
      unit: unit ?? this.unit,
      prices: prices ?? this.prices,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productCode': productCode,
      'unit': unit,
      'prices': prices.map((x) => x.toMap()).toList(),
    };
  }

  factory PricesListModel.fromMap(Map<String, dynamic> map) {
    return PricesListModel(
      productCode: map['productCode']?.toInt(),
      unit: map['unit'],
      prices: List<PricesModel>.from(
          map['prices']?.map((x) => PricesModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PricesListModel.fromJson(Map<String, dynamic> json) {
    return PricesListModel(
      productCode: json['productCode']?.toInt(),
      unit: json['unit'],
      prices: List<PricesModel>.from(
          json['prices']?.map((x) => PricesModel.fromJson(x))),
    );
  }

  @override
  String toString() =>
      'PricesListModel(productCode: $productCode, unit: $unit, prices: $prices)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PricesListModel &&
        other.productCode == productCode &&
        other.unit == unit &&
        listEquals(other.prices, prices);
  }

  @override
  int get hashCode => productCode.hashCode ^ unit.hashCode ^ prices.hashCode;
}
