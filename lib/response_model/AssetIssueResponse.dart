import 'dart:convert';

AssetIssueResponse assetIssueResponseFromJson(String str) => AssetIssueResponse.fromJson(json.decode(str));

String assetIssueResponseToJson(AssetIssueResponse data) => json.encode(data.toJson());

class AssetIssueResponse {
  bool status;
  String message;
  List<AssetIssueModel> data;

  AssetIssueResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AssetIssueResponse.fromJson(Map<String, dynamic> json) => AssetIssueResponse(
    status: json["status"],
    message: json["message"],
    data: List<AssetIssueModel>.from(json["data"].map((x) => AssetIssueModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AssetIssueModel {
  var issueNo;
  var issueDate;
  var employeeNo;
  var employeeName;
  var issuedBy;
  var issuedByName;
  int issue;
  var department;

  bool selected = false;

  AssetIssueModel({
    this.issueNo,
    this.issueDate,
    this.employeeNo,
    this.employeeName,
    this.issuedBy,
    this.issuedByName,
    this.issue,
    this.department,
  });

  factory AssetIssueModel.fromJson(Map<String, dynamic> json) => AssetIssueModel(
    issueNo: json["Issue No_"],
    issueDate: json["Issue Date"],
    employeeNo: json["Employee No_"],
    employeeName: json["Employee Name"],
    issuedBy: json["Issued By"],
    issuedByName: json["Issued By Name"],
    issue: json["Issue"],
    department: json["DEPARTMENT"],
  );

  Map<String, dynamic> toJson() => {
    "Issue No_": issueNo,
    "Issue Date": issueDate,
    "Employee No_": employeeNo,
    "Employee Name": employeeName,
    "Issued By": issuedBy,
    "Issued By Name": issuedByName,
    "Issue": issue,
    "DEPARTMENT": department,
  };
}