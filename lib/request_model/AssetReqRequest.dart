import 'dart:convert';

AssetReqRequest assetReqRequestFromJson(String str) => AssetReqRequest.fromJson(json.decode(str));

String assetReqRequestToJson(AssetReqRequest data) => json.encode(data.toJson());

class AssetReqRequest {
  int action;
  String requisitionNo;
  String requisitionDate;
  String employeeId;
  String employeeName;
  String department;
  String requestedBy;
  String requestedByName;
  String userId;
  int status;

  AssetReqRequest({
    this.action,
    this.requisitionNo,
    this.requisitionDate,
    this.employeeId,
    this.employeeName,
    this.department,
    this.requestedBy,
    this.requestedByName,
    this.userId,
    this.status,
  });

  factory AssetReqRequest.fromJson(Map<String, dynamic> json) => AssetReqRequest(
    action: json["Action"],
    requisitionNo: json["Requisition_no"],
    requisitionDate: json["Requisition_date"],
    employeeId: json["Employee_id"],
    employeeName: json["Employee_name"],
    department: json["Department"],
    requestedBy: json["Requested_by"],
    requestedByName: json["Requested_by_name"],
    userId: json["User_id"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "Action": action,
    "Requisition_no": requisitionNo,
    "Requisition_date": requisitionDate,
    "Employee_id": employeeId,
    "Employee_name": employeeName,
    "Department": department,
    "Requested_by": requestedBy,
    "Requested_by_name": requestedByName,
    "User_id": userId,
    "Status": status,
  };
}