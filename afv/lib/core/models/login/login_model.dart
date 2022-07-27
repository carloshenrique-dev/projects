import 'dart:convert';

class LoginModel {
  final String? user;
  final String? password;
  LoginModel({
    this.user,
    this.password,
  });

  LoginModel copyWith({
    String? user,
    String? password,
  }) {
    return LoginModel(
      user: user ?? this.user,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'password': password,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      user: map['user'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) => LoginModel.fromMap(json.decode(source));

  @override
  String toString() => 'LoginModel(user: $user, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LoginModel &&
      other.user == user &&
      other.password == password;
  }

  @override
  int get hashCode => user.hashCode ^ password.hashCode;
}
