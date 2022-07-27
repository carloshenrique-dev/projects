import 'dart:convert';

class PricesModel {
  final String? priceCode;
  final double? salePrice;
  final double? maxDiscount;
  final double? minPrice;
  final double? indexAdd;
  PricesModel({
    this.priceCode,
    this.salePrice,
    this.maxDiscount,
    this.minPrice,
    this.indexAdd,
  });

  PricesModel copyWith({
    String? priceCode,
    double? salePrice,
    double? maxDiscount,
    double? minPrice,
    double? indexAdd,
  }) {
    return PricesModel(
      priceCode: priceCode ?? this.priceCode,
      salePrice: salePrice ?? this.salePrice,
      maxDiscount: maxDiscount ?? this.maxDiscount,
      minPrice: minPrice ?? this.minPrice,
      indexAdd: indexAdd ?? this.indexAdd,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'priceCode': priceCode,
      'salePrice': salePrice,
      'maxDiscount': maxDiscount,
      'minPrice': minPrice,
      'indexAdd': indexAdd,
    };
  }

  factory PricesModel.fromMap(Map<String, dynamic> map) {
    return PricesModel(
      priceCode: map['priceCode'],
      salePrice: map['salePrice']?.toDouble(),
      maxDiscount: map['maxDiscount']?.toDouble(),
      minPrice: map['minPrice']?.toDouble(),
      indexAdd: map['indexAdd']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PricesModel.fromJson(Map<String, dynamic> json) {
    return PricesModel(
      priceCode: json['priceCode'],
      salePrice: json['salePrice']?.toDouble(),
      maxDiscount: json['maxDiscount']?.toDouble(),
      minPrice: json['minPrice']?.toDouble(),
      indexAdd: json['indexAdd']?.toDouble(),
    );
  }

  @override
  String toString() {
    return 'PricesModel(priceCode: $priceCode, salePrice: $salePrice, maxDiscount: $maxDiscount, minPrice: $minPrice, indexAdd: $indexAdd)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PricesModel &&
        other.priceCode == priceCode &&
        other.salePrice == salePrice &&
        other.maxDiscount == maxDiscount &&
        other.minPrice == minPrice &&
        other.indexAdd == indexAdd;
  }

  @override
  int get hashCode {
    return priceCode.hashCode ^
        salePrice.hashCode ^
        maxDiscount.hashCode ^
        minPrice.hashCode ^
        indexAdd.hashCode;
  }
}
