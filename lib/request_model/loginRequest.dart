import 'dart:convert';

LoginRequest loginReqFromJson(String str) =>
    LoginRequest.fromJson(json.decode(str));

String loginReqToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  String username;
  String password;

  LoginRequest({
    this.username,
    this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => new LoginRequest(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
