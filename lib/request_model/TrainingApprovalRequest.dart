import 'dart:convert';

TrainingApprovalRequest trainingApprovalRequestFromJson(String str) =>
    TrainingApprovalRequest.fromJson(json.decode(str));

String trainingApprovalRequestToJson(TrainingApprovalRequest data) =>
    json.encode(data.toJson());

class TrainingApprovalRequest {
  String action;
  String entryNo;
  String tableName;
  String documentType;
  String requestNo;
  String sequenceNo;
  String senderId;
  String empApproverId;
  String approverId;
  String status;
  String modifiedBy;
  String rejectionComment;
  String cancellationComment;

  TrainingApprovalRequest({
    this.action,
    this.entryNo,
    this.tableName,
    this.documentType,
    this.requestNo,
    this.sequenceNo,
    this.senderId,
    this.empApproverId,
    this.approverId,
    this.status,
    this.modifiedBy,
    this.rejectionComment,
    this.cancellationComment,
  });

  factory TrainingApprovalRequest.fromJson(Map<String, dynamic> json) =>
      new TrainingApprovalRequest(
        action: json["Action"],
        entryNo: json["EntryNo"],
        tableName: json["TableName"],
        documentType: json["DocumentType"],
        requestNo: json["RequestNo"],
        sequenceNo: json["SequenceNo"],
        senderId: json["SenderId"],
        empApproverId: json["EmpApproverId"],
        approverId: json["ApproverId"],
        status: json["status"],
        modifiedBy: json["ModifiedBy"],
        rejectionComment: json["RejectionComment"],
        cancellationComment: json["CancellationComment"],
      );

  Map<String, dynamic> toJson() => {
        "Action": action,
        "EntryNo": entryNo,
        "TableName": tableName,
        "DocumentType": documentType,
        "RequestNo": requestNo,
        "SequenceNo": sequenceNo,
        "SenderId": senderId,
        "EmpApproverId": empApproverId,
        "ApproverId": approverId,
        "status": status,
        "ModifiedBy": modifiedBy,
        "RejectionComment": rejectionComment,
        "CancellationComment": cancellationComment,
      };
}
