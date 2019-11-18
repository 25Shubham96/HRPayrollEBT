import 'dart:convert';

ForgotPasswordRequest forgotPasswordRequestFromJson(String str) =>
    ForgotPasswordRequest.fromJson(json.decode(str));

String forgotPasswordRequestToJson(ForgotPasswordRequest data) =>
    json.encode(data.toJson());

class ForgotPasswordRequest {
  String emailAddress;
  String authCode;
  String password;
  String passwordConfirm;

  ForgotPasswordRequest({
    this.emailAddress,
    this.authCode,
    this.password,
    this.passwordConfirm,
  });

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordRequest(
        emailAddress: json["EmailAddress"],
        authCode: json["AuthCode"],
        password: json["Password"],
        passwordConfirm: json["PasswordConfirm"],
      );

  Map<String, dynamic> toJson() => {
        "EmailAddress": emailAddress,
        "AuthCode": authCode,
        "Password": password,
        "PasswordConfirm": passwordConfirm,
      };
}
