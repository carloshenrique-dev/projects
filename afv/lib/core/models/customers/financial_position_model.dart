import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'financial_positions_items_model.dart';

class FinancialPositionModel {
  final int? customerCode;
  final List<FinancialPositionsItemsModel>? financialPositionItems;
  FinancialPositionModel({
    this.customerCode,
    this.financialPositionItems,
  });

  FinancialPositionModel copyWith({
    int? customerCode,
    List<FinancialPositionsItemsModel>? financialPositionItems,
  }) {
    return FinancialPositionModel(
      customerCode: customerCode ?? this.customerCode,
      financialPositionItems:
          financialPositionItems ?? this.financialPositionItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerCode': customerCode,
      'financialPositionItems':
          financialPositionItems?.map((x) => x.toMap()).toList(),
    };
  }

  factory FinancialPositionModel.fromMap(Map<String, dynamic> map) {
    return FinancialPositionModel(
      customerCode: map['customerCode']?.toInt(),
      financialPositionItems: map['financialPositionItems'] != null
          ? List<FinancialPositionsItemsModel>.from(
              map['financialPositionItems']
                  ?.map((x) => FinancialPositionsItemsModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinancialPositionModel.fromJson(Map<String, dynamic> json) {
    return FinancialPositionModel(
      customerCode: json['CustomerCode']?.toInt(),
      financialPositionItems: json['financialPositions'] != null
          ? List<FinancialPositionsItemsModel>.from(json['financialPositions']
              ?.map((x) => FinancialPositionsItemsModel.fromMap(x)))
          : null,
    );
  }

  @override
  String toString() =>
      'FinancialPositionModel(customerCode: $customerCode, financialPositionItems: $financialPositionItems)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FinancialPositionModel &&
        other.customerCode == customerCode &&
        listEquals(other.financialPositionItems, financialPositionItems);
  }

  @override
  int get hashCode => customerCode.hashCode ^ financialPositionItems.hashCode;
}
