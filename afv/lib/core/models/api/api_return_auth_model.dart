import 'dart:convert';

class ApiReturnAuthModel {
  final bool? idUp;
  final bool? active;
  ApiReturnAuthModel({
    this.idUp,
    this.active,
  });

  ApiReturnAuthModel copyWith({
    bool? idUp,
    bool? active,
  }) {
    return ApiReturnAuthModel(
      idUp: idUp ?? this.idUp,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idUp': idUp,
      'active': active,
    };
  }

  factory ApiReturnAuthModel.fromMap(Map<String, dynamic> map) {
    return ApiReturnAuthModel(
      idUp: map['idUp'],
      active: map['active'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiReturnAuthModel.fromJson(Map<String, dynamic> json) {
    return ApiReturnAuthModel(
      active: json['idUp'],
      idUp: json['active'],
    );
  }

  @override
  String toString() => 'ApiReturnAuthModel(idUp: $idUp, active: $active)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiReturnAuthModel &&
        other.idUp == idUp &&
        other.active == active;
  }

  @override
  int get hashCode => idUp.hashCode ^ active.hashCode;
}
