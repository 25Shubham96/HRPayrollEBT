import 'dart:convert';

AssessmentApprovalRequest assessmentApprovalRequestFromJson(String str) =>
    AssessmentApprovalRequest.fromJson(json.decode(str));

String assessmentApprovalRequestToJson(AssessmentApprovalRequest data) =>
    json.encode(data.toJson());

class AssessmentApprovalRequest {
  String action;
  String entryNo;
  String tableName;
  String documentType;
  String documentNo;
  String sequenceNo;
  String senderId;
  String empApproverId;
  String approverId;
  String status;
  String requisitionDate;
  String requisitionNo;
  String modifiedBy;
  String rejectionComment;
  String cancellationComment;

  AssessmentApprovalRequest({
    this.action,
    this.entryNo,
    this.tableName,
    this.documentType,
    this.documentNo,
    this.sequenceNo,
    this.senderId,
    this.empApproverId,
    this.approverId,
    this.status,
    this.requisitionDate,
    this.requisitionNo,
    this.modifiedBy,
    this.rejectionComment,
    this.cancellationComment,
  });

  factory AssessmentApprovalRequest.fromJson(Map<String, dynamic> json) =>
      new AssessmentApprovalRequest(
        action: json["Action"],
        entryNo: json["EntryNo"],
        tableName: json["TableName"],
        documentType: json["DocumentType"],
        documentNo: json["DocumentNo"],
        sequenceNo: json["SequenceNo"],
        senderId: json["SenderId"],
        empApproverId: json["EmpApproverId"],
        approverId: json["ApproverId"],
        status: json["Status"],
        requisitionDate: json["RequisitionDate"],
        requisitionNo: json["RequisitionNo"],
        modifiedBy: json["ModifiedBy"],
        rejectionComment: json["RejectionComment"],
        cancellationComment: json["CancellationComment"],
      );

  Map<String, dynamic> toJson() => {
        "Action": action,
        "EntryNo": entryNo,
        "TableName": tableName,
        "DocumentType": documentType,
        "DocumentNo": documentNo,
        "SequenceNo": sequenceNo,
        "SenderId": senderId,
        "EmpApproverId": empApproverId,
        "ApproverId": approverId,
        "Status": status,
        "RequisitionDate": requisitionDate,
        "RequisitionNo": requisitionNo,
        "ModifiedBy": modifiedBy,
        "RejectionComment": rejectionComment,
        "CancellationComment": cancellationComment,
      };
}
