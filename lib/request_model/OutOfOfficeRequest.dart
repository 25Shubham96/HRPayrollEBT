import 'dart:convert';

OutOfOfficeRequest outOfOfficeRequestFromJson(String str) =>
    OutOfOfficeRequest.fromJson(json.decode(str));

String outOfOfficeRequestToJson(OutOfOfficeRequest data) =>
    json.encode(data.toJson());

class OutOfOfficeRequest {
  int action;
  String commentCancellation;
  String commentRejection;
  String department;
  String designation;
  String employeeName;
  String employeeNo;
  String fromTime;
  String reason;
  String requestDate;
  int status;
  String toTime;
  String entryNo;

  OutOfOfficeRequest({
    this.action,
    this.commentCancellation,
    this.commentRejection,
    this.department,
    this.designation,
    this.employeeName,
    this.employeeNo,
    this.fromTime,
    this.reason,
    this.requestDate,
    this.status,
    this.toTime,
    this.entryNo,
  });

  factory OutOfOfficeRequest.fromJson(Map<String, dynamic> json) =>
      OutOfOfficeRequest(
        action: json["Action"],
        commentCancellation: json["CommentCancellation"],
        commentRejection: json["CommentRejection"],
        department: json["Department"],
        designation: json["Designation"],
        employeeName: json["EmployeeName"],
        employeeNo: json["EmployeeNo"],
        fromTime: json["FromTime"],
        reason: json["Reason"],
        requestDate: json["RequestDate"],
        status: json["Status"],
        toTime: json["ToTime"],
        entryNo: json["EntryNo"],
      );

  Map<String, dynamic> toJson() => {
        "Action": action,
        "CommentCancellation": commentCancellation,
        "CommentRejection": commentRejection,
        "Department": department,
        "Designation": designation,
        "EmployeeName": employeeName,
        "EmployeeNo": employeeNo,
        "FromTime": fromTime,
        "Reason": reason,
        "RequestDate": requestDate,
        "Status": status,
        "ToTime": toTime,
        "EntryNo": entryNo,
      };
}
