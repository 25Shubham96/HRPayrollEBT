import 'dart:convert';

LoginResponse loginResFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool status;
  String message;
  List<Datum> data;

  LoginResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      new LoginResponse(
        status: json["status"],
        message: json["message"],
        data: new List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String firstName;
  String lastName;
  String email;
  String token;
  int isLoginFirst;
  String userId;
  int roleId;
  String sessionId;
  String fcmToken;

  Datum({
    this.firstName,
    this.lastName,
    this.email,
    this.token,
    this.isLoginFirst,
    this.userId,
    this.roleId,
    this.sessionId,
    this.fcmToken,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => new Datum(
        firstName: json["FirstName"],
        lastName: json["LastName"],
        email: json["Email"],
        token: json["token"],
        isLoginFirst: json["IsLoginFirst"],
        userId: json["UserId"],
        roleId: json["RoleId"],
        sessionId: json["session_id"],
        fcmToken: json["FcmToken"],
      );

  Map<String, dynamic> toJson() => {
        "FirstName": firstName,
        "LastName": lastName,
        "Email": email,
        "token": token,
        "IsLoginFirst": isLoginFirst,
        "UserId": userId,
        "RoleId": roleId,
        "session_id": sessionId,
        "FcmToken": fcmToken,
      };
}
