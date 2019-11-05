import 'dart:convert';

OutOfOfficeResponse outOfOfficeResponseFromJson(String str) =>
    OutOfOfficeResponse.fromJson(json.decode(str));

String outOfOfficeResponseToJson(OutOfOfficeResponse data) =>
    json.encode(data.toJson());

class OutOfOfficeResponse {
  bool status;
  String message;
  List<OutOfOfficeModel> data;

  OutOfOfficeResponse({
    this.status,
    this.message,
    this.data,
  });

  factory OutOfOfficeResponse.fromJson(Map<String, dynamic> json) =>
      OutOfOfficeResponse(
        status: json["status"],
        message: json["message"],
        data: List<OutOfOfficeModel>.from(
            json["data"].map((x) => OutOfOfficeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OutOfOfficeModel {
  int entryNo;
  String employeeNo;
  String employeeName;
  String designation;
  String department;
  String requestDate;
  String fromTime;
  String toTime;
  String reason;
  String status;
  String commentForRejection;
  String commentForCancellation;
  String uniqueFromDate;

  bool selected = false;

  OutOfOfficeModel({
    this.entryNo,
    this.employeeNo,
    this.employeeName,
    this.designation,
    this.department,
    this.requestDate,
    this.fromTime,
    this.toTime,
    this.reason,
    this.status,
    this.commentForRejection,
    this.commentForCancellation,
    this.uniqueFromDate,
  });

  factory OutOfOfficeModel.fromJson(Map<String, dynamic> json) =>
      OutOfOfficeModel(
        entryNo: json["Entry No_"],
        employeeNo: json["Employee No_"],
        employeeName: json["Employee Name"],
        designation: json["Designation"],
        department: json["Department"],
        requestDate: json["Request Date"],
        fromTime: json["From Time"],
        toTime: json["To Time"],
        reason: json["Reason"],
        status: json["Status"],
        commentForRejection: json["Comment for Rejection"],
        commentForCancellation: json["Comment for Cancellation"],
        uniqueFromDate: json["UniqueFromDate"],
      );

  Map<String, dynamic> toJson() => {
        "Entry No_": entryNo,
        "Employee No_": employeeNo,
        "Employee Name": employeeName,
        "Designation": designation,
        "Department": department,
        "Request Date": requestDate,
        "From Time": fromTime,
        "To Time": toTime,
        "Reason": reason,
        "Status": status,
        "Comment for Rejection": commentForRejection,
        "Comment for Cancellation": commentForCancellation,
        "UniqueFromDate": uniqueFromDate,
      };
}
