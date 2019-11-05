import 'dart:convert';

NavigateRequest navigateReqFromJson(String str) =>
    NavigateRequest.fromJson(json.decode(str));

String navigateReqToJson(NavigateRequest data) => json.encode(data.toJson());

class NavigateRequest {
  int action;
  String employeeId;

  NavigateRequest({
    this.action,
    this.employeeId,
  });

  factory NavigateRequest.fromJson(Map<String, dynamic> json) =>
      new NavigateRequest(
        action: json["Action"],
        employeeId: json["EmployeeId"],
      );

  Map<String, dynamic> toJson() => {
        "Action": action,
        "EmployeeId": employeeId,
      };
}
