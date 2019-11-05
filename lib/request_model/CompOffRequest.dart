import 'dart:convert';

CompOffRequest compOffRequestFromJson(String str) =>
    CompOffRequest.fromJson(json.decode(str));

String compOffRequestToJson(CompOffRequest data) => json.encode(data.toJson());

class CompOffRequest {
  String employeeNo;
  String employeeName;
  String designation;
  String department;
  String fromDate;
  String toDate;
  int noOfDays;
  String taskToComplete;
  String reason;
  int status;
  int action;
  String entryNo;

  CompOffRequest({
    this.employeeNo,
    this.employeeName,
    this.designation,
    this.department,
    this.fromDate,
    this.toDate,
    this.noOfDays,
    this.taskToComplete,
    this.reason,
    this.status,
    this.action,
    this.entryNo,
  });

  factory CompOffRequest.fromJson(Map<String, dynamic> json) => CompOffRequest(
        employeeNo: json["EmployeeNo"],
        employeeName: json["EmployeeName"],
        designation: json["Designation"],
        department: json["Department"],
        fromDate: json["FromDate"],
        toDate: json["ToDate"],
        noOfDays: json["NoOfDays"],
        taskToComplete: json["TaskToComplete"],
        reason: json["Reason"],
        status: json["Status"],
        action: json["Action"],
        entryNo: json["EntryNo"],
      );

  Map<String, dynamic> toJson() => {
        "EmployeeNo": employeeNo,
        "EmployeeName": employeeName,
        "Designation": designation,
        "Department": department,
        "FromDate": fromDate,
        "ToDate": toDate,
        "NoOfDays": noOfDays,
        "TaskToComplete": taskToComplete,
        "Reason": reason,
        "Status": status,
        "Action": action,
        "EntryNo": entryNo,
      };
}
