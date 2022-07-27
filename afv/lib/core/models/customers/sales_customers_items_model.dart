import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'sales_customers_products_model.dart';

class SalesCustomersItemsModel {
  final int? customerCode;
  final int? subsidiaryCode;
  final int? salesOrder;
  final int? invoiceNumber;
  final String? saleDate;
  final String? deliveryDate;
  final String? note;
  final String? paymentCondition;
  final String? internalService;
  final String? status;
  final String? cancellationReason;
  final String? unlockUser;
  final String? ublockDate;
  final String? unlockReason;
  final double? grossAmount;
  final double? netValue;
  final double? commercialBudget;
  final String? registrationTime;
  final String? syncDate;
  final String? movementType;
  final List<SalesCustomersProductsModel>? products;
  SalesCustomersItemsModel({
    this.customerCode,
    this.subsidiaryCode,
    this.salesOrder,
    this.invoiceNumber,
    this.saleDate,
    this.deliveryDate,
    this.note,
    this.paymentCondition,
    this.internalService,
    this.status,
    this.cancellationReason,
    this.unlockUser,
    this.ublockDate,
    this.unlockReason,
    this.grossAmount,
    this.netValue,
    this.commercialBudget,
    this.registrationTime,
    this.syncDate,
    this.movementType,
    this.products,
  });

  SalesCustomersItemsModel copyWith({
    int? customerCode,
    int? subsidiaryCode,
    int? salesOrder,
    int? invoiceNumber,
    String? saleDate,
    String? deliveryDate,
    String? note,
    String? paymentCondition,
    String? internalService,
    String? status,
    String? cancellationReason,
    String? unlockUser,
    String? ublockDate,
    String? unlockReason,
    double? grossAmount,
    double? netValue,
    double? commercialBudget,
    String? registrationTime,
    String? syncDate,
    String? movementType,
    List<SalesCustomersProductsModel>? products,
  }) {
    return SalesCustomersItemsModel(
      customerCode: customerCode ?? this.customerCode,
      subsidiaryCode: subsidiaryCode ?? this.subsidiaryCode,
      salesOrder: salesOrder ?? this.salesOrder,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      saleDate: saleDate ?? this.saleDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      note: note ?? this.note,
      paymentCondition: paymentCondition ?? this.paymentCondition,
      internalService: internalService ?? this.internalService,
      status: status ?? this.status,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      unlockUser: unlockUser ?? this.unlockUser,
      ublockDate: ublockDate ?? this.ublockDate,
      unlockReason: unlockReason ?? this.unlockReason,
      grossAmount: grossAmount ?? this.grossAmount,
      netValue: netValue ?? this.netValue,
      commercialBudget: commercialBudget ?? this.commercialBudget,
      registrationTime: registrationTime ?? this.registrationTime,
      syncDate: syncDate ?? this.syncDate,
      movementType: movementType ?? this.movementType,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerCode': customerCode,
      'subsidiaryCode': subsidiaryCode,
      'salesOrder': salesOrder,
      'invoiceNumber': invoiceNumber,
      'saleDate': saleDate,
      'deliveryDate': deliveryDate,
      'note': note,
      'paymentCondition': paymentCondition,
      'internalService': internalService,
      'status': status,
      'cancellationReason': cancellationReason,
      'unlockUser': unlockUser,
      'ublockDate': ublockDate,
      'unlockReason': unlockReason,
      'grossAmount': grossAmount,
      'netValue': netValue,
      'commercialBudget': commercialBudget,
      'registrationTime': registrationTime,
      'syncDate': syncDate,
      'movementType': movementType,
      'products': products?.map((x) => x.toMap()).toList(),
    };
  }

  factory SalesCustomersItemsModel.fromMap(Map<String, dynamic> map) {
    return SalesCustomersItemsModel(
      customerCode: map['customerCode']?.toInt() ?? 0,
      subsidiaryCode: map['subsidiaryCode']?.toInt() ?? 0,
      salesOrder: map['salesOrder']?.toInt() ?? 0,
      invoiceNumber: map['invoiceNumber']?.toInt() ?? 0,
      saleDate: map['saleDate'] ?? '',
      deliveryDate: map['deliveryDate'] ?? '',
      note: map['note'] ?? '',
      paymentCondition: map['paymentCondition'] ?? '',
      internalService: map['internalService'] ?? '',
      status: map['status'] ?? '',
      cancellationReason: map['cancellationReason'] ?? '',
      unlockUser: map['unlockUser'] ?? '',
      ublockDate: map['ublockDate'] ?? '',
      unlockReason: map['unlockReason'] ?? '',
      grossAmount: map['grossAmount']?.toDouble() ?? 0.0,
      netValue: map['netValue']?.toDouble() ?? 0.0,
      commercialBudget: (map['commercialBudget']?.toDouble() != null &&
              map['commercialBudget']?.toDouble() != 0.0)
          ? map['commercialBudget']?.toDouble()
          : 0.0,
      registrationTime: map['registrationTime'] ?? '',
      syncDate: map['syncDate'] ?? '',
      movementType: map['movementType'] ?? '',
      products: map['products'] != null
          ? List<SalesCustomersProductsModel>.from(map['products']
              ?.map((x) => SalesCustomersProductsModel.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesCustomersItemsModel.fromJson(Map<String, dynamic> json) {
    return SalesCustomersItemsModel(
      customerCode: json['customerCode']?.toInt() ?? 0,
      subsidiaryCode: json['subsidiaryCode']?.toInt() ?? 0,
      salesOrder: json['salesOrder']?.toInt() ?? 0,
      invoiceNumber: json['invoiceNumber']?.toInt() ?? 0,
      saleDate: json['saleDate'] ?? '',
      deliveryDate: json['deliveryDate'] ?? '',
      note: json['note'] ?? '',
      paymentCondition: json['paymentCondition'] ?? '',
      internalService: json['internalService'] ?? '',
      status: json['status'] ?? '',
      cancellationReason: json['cancellationReason'] ?? '',
      unlockUser: json['unlockUser'] ?? '',
      ublockDate: json['ublockDate'] ?? '',
      unlockReason: json['unlockReason'] ?? '',
      grossAmount: json['grossAmount']?.toDouble() ?? 0.0,
      netValue: json['netValue']?.toDouble() ?? 0.0,
      commercialBudget: (json['commercialBudget']?.toDouble() != null &&
              json['commercialBudget']?.toDouble() != 0.0)
          ? json['commercialBudget']?.toDouble()
          : 0.0,
      registrationTime: json['registrationTime'] ?? '',
      syncDate: json['syncDate'] ?? '',
      movementType: json['movementType'] ?? '',
      products: json['products'] != null
          ? List<SalesCustomersProductsModel>.from(json['products']
              ?.map((x) => SalesCustomersProductsModel.fromMap(x)))
          : [],
    );
  }

  @override
  String toString() {
    return 'SalesCustomersItemsModel(customerCode: $customerCode, subsidiaryCode: $subsidiaryCode, salesOrder: $salesOrder, invoiceNumber: $invoiceNumber, saleDate: $saleDate, deliveryDate: $deliveryDate, note: $note, paymentCondition: $paymentCondition, internalService: $internalService, status: $status, cancellationReason: $cancellationReason, unlockUser: $unlockUser, ublockDate: $ublockDate, unlockReason: $unlockReason, grossAmount: $grossAmount, netValue: $netValue, commercialBudget: $commercialBudget, registrationTime: $registrationTime, syncDate: $syncDate, movementType: $movementType, products: $products)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SalesCustomersItemsModel &&
        other.customerCode == customerCode &&
        other.subsidiaryCode == subsidiaryCode &&
        other.salesOrder == salesOrder &&
        other.invoiceNumber == invoiceNumber &&
        other.saleDate == saleDate &&
        other.deliveryDate == deliveryDate &&
        other.note == note &&
        other.paymentCondition == paymentCondition &&
        other.internalService == internalService &&
        other.status == status &&
        other.cancellationReason == cancellationReason &&
        other.unlockUser == unlockUser &&
        other.ublockDate == ublockDate &&
        other.unlockReason == unlockReason &&
        other.grossAmount == grossAmount &&
        other.netValue == netValue &&
        other.commercialBudget == commercialBudget &&
        other.registrationTime == registrationTime &&
        other.syncDate == syncDate &&
        other.movementType == movementType &&
        listEquals(other.products, products);
  }

  @override
  int get hashCode {
    return customerCode.hashCode ^
        subsidiaryCode.hashCode ^
        salesOrder.hashCode ^
        invoiceNumber.hashCode ^
        saleDate.hashCode ^
        deliveryDate.hashCode ^
        note.hashCode ^
        paymentCondition.hashCode ^
        internalService.hashCode ^
        status.hashCode ^
        cancellationReason.hashCode ^
        unlockUser.hashCode ^
        ublockDate.hashCode ^
        unlockReason.hashCode ^
        grossAmount.hashCode ^
        netValue.hashCode ^
        commercialBudget.hashCode ^
        registrationTime.hashCode ^
        syncDate.hashCode ^
        movementType.hashCode ^
        products.hashCode;
  }
}
