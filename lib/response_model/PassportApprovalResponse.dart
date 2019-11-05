import 'dart:convert';

PassportApprovalResponse passportApprovalResponseFromJson(String str) =>
    PassportApprovalResponse.fromJson(json.decode(str));

String passportApprovalResponseToJson(PassportApprovalResponse data) =>
    json.encode(data.toJson());

class PassportApprovalResponse {
  bool status;
  String message;
  List<PassportApprovalModel> data;

  PassportApprovalResponse({
    this.status,
    this.message,
    this.data,
  });

  factory PassportApprovalResponse.fromJson(Map<String, dynamic> json) =>
      new PassportApprovalResponse(
        status: json["status"],
        message: json["message"],
        data: new List<PassportApprovalModel>.from(
            json["data"].map((x) => PassportApprovalModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PassportApprovalModel {
  int entryNo;
  String tableName;
  String documentType;
  String transactionId;
  int sequenceNo;
  String senderId;
  String employeeApproverId;
  String approverId;
  int status;
  String modifiedBy;
  String commentRejection;
  String commentCancellation;

  bool selected = false;

  PassportApprovalModel({
    this.entryNo,
    this.tableName,
    this.documentType,
    this.transactionId,
    this.sequenceNo,
    this.senderId,
    this.employeeApproverId,
    this.approverId,
    this.status,
    this.modifiedBy,
    this.commentRejection,
    this.commentCancellation,
  });

  factory PassportApprovalModel.fromJson(Map<String, dynamic> json) =>
      new PassportApprovalModel(
        entryNo: json["EntryNo"],
        tableName: json["TableName"],
        documentType: json["DocumentType"],
        transactionId: json["TransactionId"],
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
        "TransactionId": transactionId,
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
