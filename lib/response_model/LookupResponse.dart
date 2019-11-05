import 'dart:convert';

LookupResponse lookupResponseFromJson(String str) => LookupResponse.fromJson(json.decode(str));

String lookupResponseToJson(LookupResponse data) => json.encode(data.toJson());

class LookupResponse {
  bool status;
  String message;
  List<LookupModel> data;

  LookupResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LookupResponse.fromJson(Map<String, dynamic> json) => LookupResponse(
    status: json["status"],
    message: json["message"],
    data: List<LookupModel>.from(json["data"].map((x) => LookupModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class LookupModel {
  String lookupId;
  String lookupName;

  LookupModel({
    this.lookupId,
    this.lookupName,
  });

  factory LookupModel.fromJson(Map<String, dynamic> json) => LookupModel(
    lookupId: json["Lookup Id"],
    lookupName: json["Lookup Name"],
  );

  Map<String, dynamic> toJson() => {
    "Lookup Id": lookupId,
    "Lookup Name": lookupName,
  };
}