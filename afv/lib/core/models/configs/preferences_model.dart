import 'dart:convert';

class PreferencesModel {
  final String? token;
  final String? clientId;
  final int? sellerCode;
  final String? passwordClient;
  final String? user;
  final String? password;
  PreferencesModel({
    this.token,
    this.clientId,
    this.sellerCode,
    this.passwordClient,
    this.user,
    this.password,
  });

  PreferencesModel copyWith({
    String? token,
    String? clientId,
    int? sellerCode,
    String? passwordClient,
    String? user,
    String? password,
  }) {
    return PreferencesModel(
      token: token ?? this.token,
      clientId: clientId ?? this.clientId,
      sellerCode: sellerCode ?? this.sellerCode,
      passwordClient: passwordClient ?? this.passwordClient,
      user: user ?? this.user,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'clientId': clientId,
      'sellerCode': sellerCode,
      'passwordClient': passwordClient,
      'user': user,
      'password': password,
    };
  }

  factory PreferencesModel.fromMap(Map<String, dynamic> map) {
    return PreferencesModel(
      token: map['token'],
      clientId: map['clientId'],
      sellerCode: map['sellerCode']?.toInt(),
      passwordClient: map['passwordClient'],
      user: map['user'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PreferencesModel.fromJson(String source) =>
      PreferencesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PreferencesModel(token: $token, clientId: $clientId, sellerCode: $sellerCode, passwordClient: $passwordClient, user: $user, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PreferencesModel &&
        other.token == token &&
        other.clientId == clientId &&
        other.sellerCode == sellerCode &&
        other.passwordClient == passwordClient &&
        other.user == user &&
        other.password == password;
  }

  @override
  int get hashCode {
    return token.hashCode ^
        clientId.hashCode ^
        sellerCode.hashCode ^
        passwordClient.hashCode ^
        user.hashCode ^
        password.hashCode;
  }
}
