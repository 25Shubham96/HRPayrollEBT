import 'dart:convert';

ApproveListRequest leaveApproveListRequestFromJson(String str) =>
    ApproveListRequest.fromJson(json.decode(str));

String leaveApproveListRequestToJson(ApproveListRequest data) =>
    json.encode(data.toJson());

class ApproveListRequest {
  int action;
  String senderId;
  int status;

  ApproveListRequest({
    this.action,
    this.senderId,
    this.status,
  });

  factory ApproveListRequest.fromJson(Map<String, dynamic> json) =>
      ApproveListRequest(
        action: json["action"],
        senderId: json["senderId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "senderId": senderId,
        "status": status,
      };
}
