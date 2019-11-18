import 'dart:convert';

AssetIssueRequest assetIssueRequestFromJson(String str) =>
    AssetIssueRequest.fromJson(json.decode(str));

String assetIssueRequestToJson(AssetIssueRequest data) =>
    json.encode(data.toJson());

class AssetIssueRequest {
  int action;
  String issueNo;
  String issueDate;
  String employeeId;
  String employeeName;
  String requestedBy;
  String requestedByName;
  int issue;
  int retun;

  AssetIssueRequest({
    this.action,
    this.issueNo,
    this.issueDate,
    this.employeeId,
    this.employeeName,
    this.requestedBy,
    this.requestedByName,
    this.issue,
    this.retun,
  });

  factory AssetIssueRequest.fromJson(Map<String, dynamic> json) =>
      AssetIssueRequest(
        action: json["Action"],
        issueNo: json["Issue_no"],
        issueDate: json["Issue_date"],
        employeeId: json["Employee_id"],
        employeeName: json["Employee_name"],
        requestedBy: json["Requested_by"],
        requestedByName: json["Requested_by_name"],
        issue: json["Issue"],
        retun: json["Retun"],
      );

  Map<String, dynamic> toJson() => {
        "Action": action,
        "Issue_no": issueNo,
        "Issue_date": issueDate,
        "Employee_id": employeeId,
        "Employee_name": employeeName,
        "Requested_by": requestedBy,
        "Requested_by_name": requestedByName,
        "Issue": issue,
        "Retun": retun,
      };
}
