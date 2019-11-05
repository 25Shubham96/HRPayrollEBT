import 'dart:convert';

ActionRequest actionReqFromJson(String str) =>
    ActionRequest.fromJson(json.decode(str));

String actionReqToJson(ActionRequest data) => json.encode(data.toJson());

class ActionRequest {
  int action;
  String employeeId;
  String sactionIncharge;
  int hierarchy;
  String inchargeName;

  ActionRequest({
    this.action,
    this.employeeId,
    this.sactionIncharge,
    this.hierarchy,
    this.inchargeName,
  });

  factory ActionRequest.fromJson(Map<String, dynamic> json) =>
      new ActionRequest(
        action: json["Action"],
        employeeId: json["EmployeeId"],
        sactionIncharge: json["SactionIncharge"],
        hierarchy: json["Hierarchy"],
        inchargeName: json["InchargeName"],
      );

  Map<String, dynamic> toJson() => {
        "Action": action,
        "EmployeeId": employeeId,
        "SactionIncharge": sactionIncharge,
        "Hierarchy": hierarchy,
        "InchargeName": inchargeName,
      };
}
