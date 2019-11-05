import 'dart:convert';

CompOffResponse compOffResponseFromJson(String str) =>
    CompOffResponse.fromJson(json.decode(str));

String compOffResponseToJson(CompOffResponse data) =>
    json.encode(data.toJson());

class CompOffResponse {
  bool status;
  String message;
  List<CompOffModel> data;

  CompOffResponse({
    this.status,
    this.message,
    this.data,
  });

  factory CompOffResponse.fromJson(Map<String, dynamic> json) =>
      CompOffResponse(
        status: json["status"],
        message: json["message"],
        data: List<CompOffModel>.from(
            json["data"].map((x) => CompOffModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CompOffModel {
  int entryNo;
  String employeeNo;
  String employeeName;
  String designation;
  String department;
  String fromDate;
  String toDate;
  int noOfDays;
  String taskToComplete;
  String reason;
  String status;

  bool selected = false;

  CompOffModel({
    this.entryNo,
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
  });

  factory CompOffModel.fromJson(Map<String, dynamic> json) => CompOffModel(
        entryNo: json["Entry No_"],
        employeeNo: json["Employee No_"],
        employeeName: json["Employee Name"],
        designation: json["Designation"],
        department: json["Department"],
        fromDate: json["From Date"],
        toDate: json["To Date"],
        noOfDays: json["No_ of Days"],
        taskToComplete: json["Task to Complete"],
        reason: json["Reason"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "Entry No_": entryNo,
        "Employee No_": employeeNo,
        "Employee Name": employeeName,
        "Designation": designation,
        "Department": department,
        "From Date": fromDate,
        "To Date": toDate,
        "No_ of Days": noOfDays,
        "Task to Complete": taskToComplete,
        "Reason": reason,
        "Status": status,
      };
}
