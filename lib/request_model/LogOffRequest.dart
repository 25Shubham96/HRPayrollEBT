import 'dart:convert';

LogOffRequest logOffRequestFromJson(String str) =>
    LogOffRequest.fromJson(json.decode(str));

String logOffRequestToJson(LogOffRequest data) => json.encode(data.toJson());

class LogOffRequest {
  String username;
  String password;

  LogOffRequest({
    this.username,
    this.password,
  });

  factory LogOffRequest.fromJson(Map<String, dynamic> json) => LogOffRequest(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
