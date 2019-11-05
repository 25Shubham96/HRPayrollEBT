import 'dart:convert';

AssessmentApprovalResponse assessmentApprovalResponseFromJson(String str) =>
    AssessmentApprovalResponse.fromJson(json.decode(str));

String assessmentApprovalResponseToJson(AssessmentApprovalResponse data) =>
    json.encode(data.toJson());

class AssessmentApprovalResponse {
  bool status;
  String message;
  List<AssessmentApprovalModel> data;

  AssessmentApprovalResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AssessmentApprovalResponse.fromJson(Map<String, dynamic> json) =>
      new AssessmentApprovalResponse(
        status: json["status"],
        message: json["message"],
        data: new List<AssessmentApprovalModel>.from(
            json["data"].map((x) => AssessmentApprovalModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AssessmentApprovalModel {
  int entryNo;
  String tableName;
  String documentType;
  String requisitionNo;
  String requisitionDate;
  int sequenceNo;
  String senderId;
  String employeeApproverId;
  String approverId;
  String status;
  String modifiedBy;
  String commentRejection;
  String commentCancellation;

  bool selected = false;

  AssessmentApprovalModel({
    this.entryNo,
    this.tableName,
    this.documentType,
    this.requisitionNo,
    this.requisitionDate,
    this.sequenceNo,
    this.senderId,
    this.employeeApproverId,
    this.approverId,
    this.status,
    this.modifiedBy,
    this.commentRejection,
    this.commentCancellation,
  });

  factory AssessmentApprovalModel.fromJson(Map<String, dynamic> json) =>
      new AssessmentApprovalModel(
        entryNo: json["EntryNo"],
        tableName: json["TableName"],
        documentType: json["DocumentType"],
        requisitionNo: json["Requisition No_"],
        requisitionDate: json["RequisitionDate"],
        sequenceNo: json["SequenceNo"],
        senderId: json["SenderId"],
        employeeApproverId: json["EmployeeApproverId"],
        approverId: json["ApproverId"],
        status: json["Status"],
        modifiedBy: json["ModifiedBy"],
        commentRejection: json["CommentRejection"],
        commentCancellation: json["CommentCancellation"],
      );

  Map<String, dynamic> toJson() => {
        "EntryNo": entryNo,
        "TableName": tableName,
        "DocumentType": documentType,
        "Requisition No_": requisitionNo,
        "RequisitionDate": requisitionDate,
        "SequenceNo": sequenceNo,
        "SenderId": senderId,
        "EmployeeApproverId": employeeApproverId,
        "ApproverId": approverId,
        "Status": status,
        "ModifiedBy": modifiedBy,
        "CommentRejection": commentRejection,
        "CommentCancellation": commentCancellation,
      };
}
