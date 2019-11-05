import 'dart:convert';

PassportApproveListResponse passportApproveListResponseFromJson(String str) => PassportApproveListResponse.fromJson(json.decode(str));

String passportApproveListResponseToJson(PassportApproveListResponse data) => json.encode(data.toJson());

class PassportApproveListResponse {
  bool status;
  String message;
  List<PassportApproveListModel> data;

  PassportApproveListResponse({
    this.status,
    this.message,
    this.data,
  });

  factory PassportApproveListResponse.fromJson(Map<String, dynamic> json) => PassportApproveListResponse(
    status: json["status"],
    message: json["message"],
    data: List<PassportApproveListModel>.from(json["data"].map((x) => PassportApproveListModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PassportApproveListModel {
  var tableName;
  var documentType;
  var transactionId;
  var sequenceNo;
  var senderId;
  var employeeApproverId;
  var approverId;
  var status;
  var modifiedBy;
  var commentRejection;
  var commentCancellation;

  bool selected = false;

  PassportApproveListModel({
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

  factory PassportApproveListModel.fromJson(Map<String, dynamic> json) => PassportApproveListModel(
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