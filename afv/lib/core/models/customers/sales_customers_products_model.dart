import 'dart:convert';

class SalesCustomersProductsModel {
  final int? salesOrder;
  final int? customerCode;
  final int? item;
  final int? productCode;
  final String? productDescription;
  final String? unit;
  final int? invoicedQty;
  final int? requestQty;
  final double? unitAmount;
  final double? totalAmount;
  final String? status;
  final String? cancellationReason;
  final String? priceList;
  final double? originalSaleValue;
  final String? typeOperation;

  SalesCustomersProductsModel({
    this.salesOrder,
    this.customerCode,
    this.item,
    this.productCode,
    this.productDescription,
    this.unit,
    this.invoicedQty,
    this.requestQty,
    this.unitAmount,
    this.totalAmount,
    this.status,
    this.cancellationReason,
    this.priceList,
    this.originalSaleValue,
    this.typeOperation,
  });

  SalesCustomersProductsModel copyWith({
    int? salesOrder,
    int? customerCode,
    int? item,
    int? productCode,
    String? productDescription,
    String? unit,
    int? invoicedQty,
    int? requestQty,
    double? unitAmount,
    double? totalAmount,
    String? status,
    String? cancellationReason,
    String? priceList,
    double? originalSaleValue,
    String? typeOperation,
  }) {
    return SalesCustomersProductsModel(
      salesOrder: salesOrder ?? this.salesOrder,
      customerCode: customerCode ?? this.customerCode,
      item: item ?? this.item,
      productCode: productCode ?? this.productCode,
      productDescription: productDescription ?? this.productDescription,
      unit: unit ?? this.unit,
      invoicedQty: invoicedQty ?? this.invoicedQty,
      requestQty: requestQty ?? this.requestQty,
      unitAmount: unitAmount ?? this.unitAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      priceList: priceList ?? this.priceList,
      originalSaleValue: originalSaleValue ?? this.originalSaleValue,
      typeOperation: typeOperation ?? this.typeOperation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'salesOrder': salesOrder,
      'customerCode': customerCode,
      'item': item,
      'productCode': productCode,
      'productDescription': productDescription,
      'unit': unit,
      'invoicedQty': invoicedQty,
      'requestQty': requestQty,
      'unitAmount': unitAmount,
      'totalAmount': totalAmount,
      'status': status,
      'cancellationReason': cancellationReason,
      'priceList': priceList,
      'originalSaleValue': originalSaleValue,
      'typeOperation': typeOperation,
    };
  }

  factory SalesCustomersProductsModel.fromMap(Map<String, dynamic> map) {
    return SalesCustomersProductsModel(
      salesOrder: map['salesOrder']?.toInt() ?? 0,
      customerCode: map['customerCode']?.toInt() ?? 0,
      item: map['item']?.toInt() ?? 0,
      productCode: map['productCode']?.toInt() ?? 0,
      productDescription: map['productDescription'],
      unit: map['unit'] ?? '',
      invoicedQty: map['invoicedQty']?.toInt() ?? 0,
      requestQty: map['requestQty']?.toInt() ?? 0,
      unitAmount: map['unitAmount']?.toDouble() ?? 0.0,
      totalAmount: map['totalAmount']?.toDouble() ?? 0.0,
      status: map['status'] ?? '',
      cancellationReason: map['cancellationReason'] ?? '',
      priceList: map['priceList'] ?? '',
      originalSaleValue: map['originalSaleValue']?.toDouble() ?? 0.0,
      typeOperation: map['typeOperation'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesCustomersProductsModel.fromJson(Map<String, dynamic> json) {
    return SalesCustomersProductsModel(
      salesOrder: json['salesOrder']?.toInt() ?? 0,
      customerCode: json['customerCode']?.toInt() ?? 0,
      item: json['item']?.toInt() ?? 0,
      productCode: json['productCode']?.toInt() ?? 0,
      productDescription: json['productDescription'] ?? '',
      unit: json['unit'] ?? '',
      invoicedQty: json['invoicedQty']?.toInt() ?? 0,
      requestQty: json['requestQty']?.toInt() ?? 0,
      unitAmount: json['unitAmount']?.toDouble() ?? 0.0,
      totalAmount: json['totalAmount']?.toDouble() ?? 0.0,
      status: json['status'] ?? '',
      cancellationReason: json['cancellationReason'] ?? '',
      priceList: json['priceList'] ?? '',
      originalSaleValue: json['originalSaleValue']?.toDouble() ?? 0.0,
      typeOperation: json['typeOperation'] ?? '',
    );
  }

  @override
  String toString() {
    return 'SalesCustomersProductsModel(salesOrder: $salesOrder, customerCode: $customerCode, item: $item, productCode: $productCode, productDescription: $productDescription, unit: $unit, invoicedQty: $invoicedQty, requestQty: $requestQty, unitAmount: $unitAmount, totalAmount: $totalAmount, status: $status, cancellationReason: $cancellationReason, priceList: $priceList, originalSaleValue: $originalSaleValue, typeOperation: $typeOperation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SalesCustomersProductsModel &&
        other.salesOrder == salesOrder &&
        other.customerCode == customerCode &&
        other.item == item &&
        other.productCode == productCode &&
        other.productDescription == productDescription &&
        other.unit == unit &&
        other.invoicedQty == invoicedQty &&
        other.requestQty == requestQty &&
        other.unitAmount == unitAmount &&
        other.totalAmount == totalAmount &&
        other.status == status &&
        other.cancellationReason == cancellationReason &&
        other.priceList == priceList &&
        other.originalSaleValue == originalSaleValue &&
        other.typeOperation == typeOperation;
  }

  @override
  int get hashCode {
    return salesOrder.hashCode ^
        customerCode.hashCode ^
        item.hashCode ^
        productCode.hashCode ^
        productDescription.hashCode ^
        unit.hashCode ^
        invoicedQty.hashCode ^
        requestQty.hashCode ^
        unitAmount.hashCode ^
        totalAmount.hashCode ^
        status.hashCode ^
        cancellationReason.hashCode ^
        priceList.hashCode ^
        originalSaleValue.hashCode ^
        typeOperation.hashCode;
  }
}
