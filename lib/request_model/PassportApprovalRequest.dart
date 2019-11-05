import 'dart:convert';

PassportApprovalRequest passportApprovalRequestFromJson(String str) =>
    PassportApprovalRequest.fromJson(json.decode(str));

String passportApprovalRequestToJson(PassportApprovalRequest data) =>
    json.encode(data.toJson());

class PassportApprovalRequest {
  String action;
  String entryNo;
  String tableName;
  String documentType;
  String sequenceNo;
  String senderId;
  String empApproverId;
  String approverId;
  String status;
  String modifiedBy;
  String rejectionComment;
  String cancellationComment;
  String transactionId;
  String date;

  PassportApprovalRequest({
    this.action,
    this.entryNo,
    this.tableName,
    this.documentType,
    this.sequenceNo,
    this.senderId,
    this.empApproverId,
    this.approverId,
    this.status,
    this.modifiedBy,
    this.rejectionComment,
    this.cancellationComment,
    this.transactionId,
    this.date,
  });

  factory PassportApprovalRequest.fromJson(Map<String, dynamic> json) =>
      new PassportApprovalRequest(
        action: json["Action"],
        entryNo: json["EntryNo"],
        tableName: json["TableName"],
        documentType: json["DocumentType"],
        sequenceNo: json["SequenceNo"],
        senderId: json["SenderId"],
        empApproverId: json["EmpApproverId"],
        approverId: json["ApproverId"],
        status: json["status"],
        modifiedBy: json["ModifiedBy"],
        rejectionComment: json["RejectionComment"],
        cancellationComment: json["CancellationComment"],
        transactionId: json["TransactionId"],
        date: json["Date"],
      );

  Map<String, dynamic> toJson() => {
        "Action": action,
        "EntryNo": entryNo,
        "TableName": tableName,
        "DocumentType": documentType,
        "SequenceNo": sequenceNo,
        "SenderId": senderId,
        "EmpApproverId": empApproverId,
        "ApproverId": approverId,
        "status": status,
        "ModifiedBy": modifiedBy,
        "RejectionComment": rejectionComment,
        "CancellationComment": cancellationComment,
        "TransactionId": transactionId,
        "Date": date,
      };
}
