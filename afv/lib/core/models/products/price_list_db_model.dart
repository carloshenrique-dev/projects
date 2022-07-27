import 'dart:convert';

class PriceListDbModel {
  final int? productCode;
  final String? unit;
  final String? priceCode;
  final double? salePrice;
  final double? maxDiscount;
  final double? minPrice;
  final double? indexAdd;
  PriceListDbModel({
    this.productCode,
    this.unit,
    this.priceCode,
    this.salePrice,
    this.maxDiscount,
    this.minPrice,
    this.indexAdd,
  });

  PriceListDbModel copyWith({
    int? productCode,
    String? unit,
    String? priceCode,
    double? salePrice,
    double? maxDiscount,
    double? minPrice,
    double? indexAdd,
  }) {
    return PriceListDbModel(
      productCode: productCode ?? this.productCode,
      unit: unit ?? this.unit,
      priceCode: priceCode ?? this.priceCode,
      salePrice: salePrice ?? this.salePrice,
      maxDiscount: maxDiscount ?? this.maxDiscount,
      minPrice: minPrice ?? this.minPrice,
      indexAdd: indexAdd ?? this.indexAdd,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productCode': productCode,
      'unit': unit,
      'priceCode': priceCode,
      'salePrice': salePrice,
      'maxDiscount': maxDiscount,
      'minPrice': minPrice,
      'indexAdd': indexAdd,
    };
  }

  factory PriceListDbModel.fromMap(Map<String, dynamic> map) {
    return PriceListDbModel(
      productCode: map['productCode']?.toInt(),
      unit: map['unit'],
      priceCode: map['priceCode'],
      salePrice: map['salePrice']?.toDouble(),
      maxDiscount: map['maxDiscount']?.toDouble(),
      minPrice: map['minPrice']?.toDouble(),
      indexAdd: map['indexAdd']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceListDbModel.fromJson(Map<String, dynamic> json) {
    return PriceListDbModel(
      productCode: json['productCode']?.toInt(),
      unit: json['unit'],
      priceCode: json['priceCode'],
      salePrice: json['salePrice']?.toDouble(),
      maxDiscount: json['maxDiscount']?.toDouble(),
      minPrice: json['minPrice']?.toDouble(),
      indexAdd: json['indexAdd']?.toDouble(),
    );
  }

  @override
  String toString() {
    return 'PriceListDbModel(productCode: $productCode, unit: $unit, priceCode: $priceCode, salePrice: $salePrice, maxDiscount: $maxDiscount, minPrice: $minPrice, indexAdd: $indexAdd)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PriceListDbModel &&
        other.productCode == productCode &&
        other.unit == unit &&
        other.priceCode == priceCode &&
        other.salePrice == salePrice &&
        other.maxDiscount == maxDiscount &&
        other.minPrice == minPrice &&
        other.indexAdd == indexAdd;
  }

  @override
  int get hashCode {
    return productCode.hashCode ^
        unit.hashCode ^
        priceCode.hashCode ^
        salePrice.hashCode ^
        maxDiscount.hashCode ^
        minPrice.hashCode ^
        indexAdd.hashCode;
  }
}
