import 'dart:convert';

BusinessTripResponse businessTripResponseFromJson(String str) =>
    BusinessTripResponse.fromJson(json.decode(str));

String businessTripResponseToJson(BusinessTripResponse data) =>
    json.encode(data.toJson());

class BusinessTripResponse {
  bool status;
  String message;
  List<BusinessTripModel> data;

  BusinessTripResponse({
    this.status,
    this.message,
    this.data,
  });

  factory BusinessTripResponse.fromJson(Map<String, dynamic> json) =>
      BusinessTripResponse(
        status: json["status"],
        message: json["message"],
        data: List<BusinessTripModel>.from(
            json["data"].map((x) => BusinessTripModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BusinessTripModel {
  int entryNo;
  String employeeNo;
  String employeeName;
  String fromDate;
  String toDate;
  String reasonForTrip;
  String department;
  String status;
  String commentForRejection;
  String commentForCancellation;
  String uniqueFromDate;

  bool selected = false;

  BusinessTripModel({
    this.entryNo,
    this.employeeNo,
    this.employeeName,
    this.fromDate,
    this.toDate,
    this.reasonForTrip,
    this.department,
    this.status,
    this.commentForRejection,
    this.commentForCancellation,
    this.uniqueFromDate,
  });

  factory BusinessTripModel.fromJson(Map<String, dynamic> json) =>
      BusinessTripModel(
        entryNo: json["Entry No_"],
        employeeNo: json["Employee No_"],
        employeeName: json["Employee Name"],
        fromDate: json["From Date"],
        toDate: json["To Date"],
        reasonForTrip: json["Reason For Trip"],
        department: json["Department"],
        status: json["Status"],
        commentForRejection: json["Comment for Rejection"],
        commentForCancellation: json["Comment for Cancellation"],
        uniqueFromDate: json["UniqueFromDate"],
      );

  Map<String, dynamic> toJson() => {
        "Entry No_": entryNo,
        "Employee No_": employeeNo,
        "Employee Name": employeeName,
        "From Date": fromDate,
        "To Date": toDate,
        "Reason For Trip": reasonForTrip,
        "Department": department,
        "Status": status,
        "Comment for Rejection": commentForRejection,
        "Comment for Cancellation": commentForCancellation,
        "UniqueFromDate": uniqueFromDate,
      };
}
