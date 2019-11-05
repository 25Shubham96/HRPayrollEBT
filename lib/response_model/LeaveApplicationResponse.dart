import 'dart:convert';

LeaveApplicationResponse leaveApplicationResponseFromJson(String str) =>
    LeaveApplicationResponse.fromJson(json.decode(str));

String leaveApplicationResponseToJson(LeaveApplicationResponse data) =>
    json.encode(data.toJson());

class LeaveApplicationResponse {
  bool status;
  String message;
  List<LeaveApplicationModel> data;

  LeaveApplicationResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LeaveApplicationResponse.fromJson(Map<String, dynamic> json) =>
      new LeaveApplicationResponse(
        status: json["status"],
        message: json["message"],
        data: new List<LeaveApplicationModel>.from(
            json["data"].map((x) => LeaveApplicationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LeaveApplicationModel {
  var documentNo;
  var employeeNo;
  var employeeName;
  var leaveCode;
  var leaveDescription;
  var leaveDuration;
  var fromDate;
  var toDate;
  var noOfDays;
  var reasonForLeave;
  var status;
  var sanctioned;
  var leavesAvailCurrMonth;
  var sanctioningIncharge;
  var dateOfSanction;
  var dateOfCancellation;
  var cancellationConfirmed;
  var applicationDate;
  var specifyWorkingDay;
  var sendForApprovalDateTime;
  var rejectionComment;
  var contactDetailsLeavePeriod;
  var uniqueFromDate;

  bool selected = false;

  LeaveApplicationModel({
    this.documentNo,
    this.employeeNo,
    this.employeeName,
    this.leaveCode,
    this.leaveDescription,
    this.leaveDuration,
    this.fromDate,
    this.toDate,
    this.noOfDays,
    this.reasonForLeave,
    this.status,
    this.sanctioned,
    this.leavesAvailCurrMonth,
    this.sanctioningIncharge,
    this.dateOfSanction,
    this.dateOfCancellation,
    this.cancellationConfirmed,
    this.applicationDate,
    this.specifyWorkingDay,
    this.sendForApprovalDateTime,
    this.rejectionComment,
    this.contactDetailsLeavePeriod,
    this.uniqueFromDate,
  });

  factory LeaveApplicationModel.fromJson(Map<String, dynamic> json) =>
      new LeaveApplicationModel(
        documentNo: json["DocumentNo"],
        employeeNo: json["Employee No_"],
        employeeName: json["Employee Name"],
        leaveCode: json["Leave Code"],
        leaveDescription: json["Leave Description"],
        leaveDuration: json["Leave Duration"],
        fromDate: json["From Date"],
        toDate: json["To Date"],
        noOfDays: json["No_of Days"],
        reasonForLeave: json["Reason for Leave"],
        status: json["Status"],
        sanctioned: json["Sanctioned"],
        leavesAvailCurrMonth: json["Leaves avail_curr_Month"],
        sanctioningIncharge: json["Sanctioning Incharge"],
        dateOfSanction: json["Date of Sanction"],
        dateOfCancellation: json["Date of Cancellation"],
        cancellationConfirmed: json["Cancellation Confirmed"],
        applicationDate: json["Application Date"],
        specifyWorkingDay: json["Specify working Day"],
        sendForApprovalDateTime: json["Send for Approval DateTime"],
        rejectionComment: json["Rejection Comment"],
        contactDetailsLeavePeriod: json["Contact Details (Leave Period)"],
        uniqueFromDate: json["UniqueFromDate"],
      );

  Map<String, dynamic> toJson() => {
        "DocumentNo": documentNo,
        "Employee No_": employeeNo,
        "Employee Name": employeeName,
        "Leave Code": leaveCode,
        "Leave Description": leaveDescription,
        "Leave Duration": leaveDuration,
        "From Date": fromDate,
        "To Date": toDate,
        "No_of Days": noOfDays,
        "Reason for Leave": reasonForLeave,
        "Status": status,
        "Sanctioned": sanctioned,
        "Leaves avail_curr_Month": leavesAvailCurrMonth,
        "Sanctioning Incharge": sanctioningIncharge,
        "Date of Sanction": dateOfSanction,
        "Date of Cancellation": dateOfCancellation,
        "Cancellation Confirmed": cancellationConfirmed,
        "Application Date": applicationDate,
        "Specify working Day": specifyWorkingDay,
        "Send for Approval DateTime": sendForApprovalDateTime,
        "Rejection Comment": rejectionComment,
        "Contact Details (Leave Period)": contactDetailsLeavePeriod,
        "UniqueFromDate": uniqueFromDate,
      };
}
