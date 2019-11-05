import 'dart:convert';

LeaveMasterRequest leaveMasterRequestFromJson(String str) =>
    LeaveMasterRequest.fromJson(json.decode(str));

String leaveMasterRequestToJson(LeaveMasterRequest data) =>
    json.encode(data.toJson());

class LeaveMasterRequest {
  int action;

  LeaveMasterRequest({
    this.action,
  });

  factory LeaveMasterRequest.fromJson(Map<String, dynamic> json) =>
      new LeaveMasterRequest(
        action: json["Action"],
      );

  Map<String, dynamic> toJson() => {
        "Action": action,
      };
}
