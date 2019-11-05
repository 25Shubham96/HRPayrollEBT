import 'dart:convert';

RejCanPostResponse RejCanPostResFromJson(String str) =>
    RejCanPostResponse.fromJson(json.decode(str));

String RejCanPostResToJson(RejCanPostResponse data) => json.encode(data.toJson());

class RejCanPostResponse {
  bool status;
  String message;
  List<dynamic> data;

  RejCanPostResponse({
    this.status,
    this.message,
    this.data,
  });

  factory RejCanPostResponse.fromJson(Map<String, dynamic> json) =>
      new RejCanPostResponse(
        status: json["status"],
        message: json["message"],
        data: new List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": new List<dynamic>.from(data.map((x) => x)),
      };
}
