import 'dart:convert';

NoSeriesResponse noSeriesResponseFromJson(String str) => NoSeriesResponse.fromJson(json.decode(str));

String noSeriesResponseToJson(NoSeriesResponse data) => json.encode(data.toJson());

class NoSeriesResponse {
  bool status;
  String message;
  List<dynamic> data;

  NoSeriesResponse({
    this.status,
    this.message,
    this.data,
  });

  factory NoSeriesResponse.fromJson(Map<String, dynamic> json) => NoSeriesResponse(
    status: json["status"],
    message: json["message"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}