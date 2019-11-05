import 'dart:convert';

LeaveApprovalRequest leaveApprovalRequestFromJson(String str) =>
    LeaveApprovalRequest.fromJson(json.decode(str));

String leaveApprovalRequestToJson(LeaveApprovalRequest data) =>
    json.encode(data.toJson());

class LeaveApprovalRequest {
  String action;
  String empApproverId;
  String status;
  String entryNo;
  String tableName;
  String documentType;
  String documentNo;
  String sequenceNo;
  String senderId;
  String approverId;
  String fromDate;
  String toDate;
  String modifiedBy;
  String rejectionComment;
  String cancellationComment;

  LeaveApprovalRequest({
    this.action,
    this.empApproverId,
    this.status,
    this.entryNo,
    this.tableName,
    this.documentType,
    this.documentNo,
    this.sequenceNo,
    this.senderId,
    this.approverId,
    this.fromDate,
    this.toDate,
    this.modifiedBy,
    this.rejectionComment,
    this.cancellationComment,
  });

  factory LeaveApprovalRequest.fromJson(Map<String, dynamic> json) =>
      new LeaveApprovalRequest(
        action: json["Action"],
        empApproverId: json["EmpApproverId"],
        status: json["Status"],
        entryNo: json["EntryNo"],
        tableName: json["TableName"],
        documentType: json["DocumentType"],
        documentNo: json["DocumentNo"],
        sequenceNo: json["SequenceNo"],
        senderId: json["SenderId"],
        approverId: json["ApproverId"],
        fromDate: json["FromDate"],
        toDate: json["ToDate"],
        modifiedBy: json["ModifiedBy"],
        rejectionComment: json["RejectionComment"],
        cancellationComment: json["CancellationComment"],
      );

  Map<String, dynamic> toJson() => {
        "Action": action,
        "EmpApproverId": empApproverId,
        "Status": status,
        "EntryNo": entryNo,
        "TableName": tableName,
        "DocumentType": documentType,
        "DocumentNo": documentNo,
        "SequenceNo": sequenceNo,
        "SenderId": senderId,
        "ApproverId": approverId,
        "FromDate": fromDate,
        "ToDate": toDate,
        "ModifiedBy": modifiedBy,
        "RejectionComment": rejectionComment,
        "CancellationComment": cancellationComment,
      };
}
