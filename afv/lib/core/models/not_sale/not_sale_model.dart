import 'dart:convert';

class NotSaleModel {
  final int code;
  final String motive;

  NotSaleModel({
    required this.code,
    required this.motive,
  });

  NotSaleModel copyWith({
    int? code,
    String? motive,
  }) {
    return NotSaleModel(
      code: code ?? this.code,
      motive: motive ?? this.motive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'motive': motive,
    };
  }

  factory NotSaleModel.fromMap(Map<String, dynamic> map) {
    return NotSaleModel(
      code: map['code']?.toInt() ?? 0,
      motive: map['motive'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotSaleModel.fromJson(Map<String, dynamic> data) {
    return NotSaleModel(
      code: data['code'],
      motive: data['motive'],
    );
  }

  @override
  String toString() => 'NotSaleModel(code: $code, motive: $motive)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotSaleModel &&
        other.code == code &&
        other.motive == motive;
  }

  @override
  int get hashCode => code.hashCode ^ motive.hashCode;
}
