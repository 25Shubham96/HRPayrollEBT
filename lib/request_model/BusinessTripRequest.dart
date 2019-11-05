import 'dart:convert';

BusinessTripRequest businessTripRequestFromJson(String str) =>
    BusinessTripRequest.fromJson(json.decode(str));

String businessTripRequestToJson(BusinessTripRequest data) =>
    json.encode(data.toJson());

class BusinessTripRequest {
  int action;
  String commentCancellation;
  String commentRejection;
  String department;
  String employeeName;
  String employeeNo;
  String fromDate;
  String reason;
  String requestDate;
  int status;
  String toDate;
  String entryNo;

  BusinessTripRequest({
    this.action,
    this.commentCancellation,
    this.commentRejection,
    this.department,
    this.employeeName,
    this.employeeNo,
    this.fromDate,
    this.reason,
    this.requestDate,
    this.status,
    this.toDate,
    this.entryNo,
  });

  factory BusinessTripRequest.fromJson(Map<String, dynamic> json) =>
      BusinessTripRequest(
        action: json["Action"],
        commentCancellation: json["CommentCancellation"],
        commentRejection: json["CommentRejection"],
        department: json["Department"],
        employeeName: json["EmployeeName"],
        employeeNo: json["EmployeeNo"],
        fromDate: json["FromDate"],
        reason: json["Reason"],
        requestDate: json["RequestDate"],
        status: json["Status"],
        toDate: json["ToDate"],
        entryNo: json["EntryNo"],
      );

  Map<String, dynamic> toJson() => {
        "Action": action,
        "CommentCancellation": commentCancellation,
        "CommentRejection": commentRejection,
        "Department": department,
        "EmployeeName": employeeName,
        "EmployeeNo": employeeNo,
        "FromDate": fromDate,
        "Reason": reason,
        "RequestDate": requestDate,
        "Status": status,
        "ToDate": toDate,
        "EntryNo": entryNo,
      };
}
