import 'dart:convert';

LeaveApplicationRequest leaveApplicationRequestFromJson(String str) =>
    LeaveApplicationRequest.fromJson(json.decode(str));

String leaveApplicationRequestToJson(LeaveApplicationRequest data) =>
    json.encode(data.toJson());

class LeaveApplicationRequest {
  var employeeNo;
  var employeeName;
  var leaveCode;
  var leaveDescription;
  var leaveDuration;
  var fromDate;
  var toDate;
  var noDays;
  var reasonLeave;
  var contactDetail;
  var sanctionIncharge;
  var snactioned;
  var leavesAvailableCcy;
  var specifyWorkDay;
  var approvalDateTime;
  var rejectComment;
  var cancelConfirm;
  var applicationDate;
  var uniqueFromDate;
  var status;
  var action;
  var documentNo;

  LeaveApplicationRequest({
    this.employeeNo,
    this.employeeName,
    this.leaveCode,
    this.leaveDescription,
    this.leaveDuration,
    this.fromDate,
    this.toDate,
    this.noDays,
    this.reasonLeave,
    this.contactDetail,
    this.sanctionIncharge,
    this.snactioned,
    this.leavesAvailableCcy,
    this.specifyWorkDay,
    this.approvalDateTime,
    this.rejectComment,
    this.cancelConfirm,
    this.applicationDate,
    this.uniqueFromDate,
    this.status,
    this.action,
    this.documentNo,
  });

  factory LeaveApplicationRequest.fromJson(Map<String, dynamic> json) =>
      new LeaveApplicationRequest(
        employeeNo: json["EmployeeNo"],
        employeeName: json["EmployeeName"],
        leaveCode: json["LeaveCode"],
        leaveDescription: json["LeaveDescription"],
        leaveDuration: json["LeaveDuration"],
        fromDate: json["FromDate"],
        toDate: json["ToDate"],
        noDays: json["NoDays"],
        reasonLeave: json["ReasonLeave"],
        contactDetail: json["ContactDetail"],
        sanctionIncharge: json["SanctionIncharge"],
        snactioned: json["Snactioned"],
        leavesAvailableCcy: json["LeavesAvailableCcy"],
        specifyWorkDay: json["SpecifyWorkDay"],
        approvalDateTime: json["ApprovalDateTime"],
        rejectComment: json["RejectComment"],
        cancelConfirm: json["CancelConfirm"],
        applicationDate: json["ApplicationDate"],
        uniqueFromDate: json["UniqueFromDate"],
        status: json["Status"],
        action: json["Action"],
        documentNo: json["DocumentNo"],
      );

  Map<String, dynamic> toJson() => {
        "EmployeeNo": employeeNo,
        "EmployeeName": employeeName,
        "LeaveCode": leaveCode,
        "LeaveDescription": leaveDescription,
        "LeaveDuration": leaveDuration,
        "FromDate": fromDate,
        "ToDate": toDate,
        "NoDays": noDays,
        "ReasonLeave": reasonLeave,
        "ContactDetail": contactDetail,
        "SanctionIncharge": sanctionIncharge,
        "Snactioned": snactioned,
        "LeavesAvailableCcy": leavesAvailableCcy,
        "SpecifyWorkDay": specifyWorkDay,
        "ApprovalDateTime": approvalDateTime,
        "RejectComment": rejectComment,
        "CancelConfirm": cancelConfirm,
        "ApplicationDate": applicationDate,
        "UniqueFromDate": uniqueFromDate,
        "Status": status,
        "Action": action,
        "DocumentNo": documentNo,
      };
}
