import 'dart:convert';

class AuthModel {
  final String? clientId;
  final String? password;
  final int? sellerCode;
  AuthModel({
    this.clientId,
    this.password,
    this.sellerCode,
  });

  AuthModel copyWith({
    String? clientId,
    String? password,
    int? sellerCode,
  }) {
    return AuthModel(
      clientId: clientId ?? this.clientId,
      password: password ?? this.password,
      sellerCode: sellerCode ?? this.sellerCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'password': password,
      'sellerCode': sellerCode,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      clientId: map['clientId'],
      password: map['password'],
      sellerCode: map['sellerCode']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));

  @override
  String toString() => 'AuthModel(clientId: $clientId, password: $password, sellerCode: $sellerCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AuthModel &&
      other.clientId == clientId &&
      other.password == password &&
      other.sellerCode == sellerCode;
  }

  @override
  int get hashCode => clientId.hashCode ^ password.hashCode ^ sellerCode.hashCode;
}
