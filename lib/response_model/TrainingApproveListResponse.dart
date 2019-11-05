import 'dart:convert';

TrainingApproveListResponse trainingApproveListResponseFromJson(String str) => TrainingApproveListResponse.fromJson(json.decode(str));

String trainingApproveListResponseToJson(TrainingApproveListResponse data) => json.encode(data.toJson());

class TrainingApproveListResponse {
  bool status;
  String message;
  List<TrainingApproveListModel> data;

  TrainingApproveListResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TrainingApproveListResponse.fromJson(Map<String, dynamic> json) => TrainingApproveListResponse(
    status: json["status"],
    message: json["message"],
    data: List<TrainingApproveListModel>.from(json["data"].map((x) => TrainingApproveListModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TrainingApproveListModel {
  var tableName;
  var documentType;
  var requestCode;
  var sequenceNo;
  var senderId;
  var employeeApproverId;
  var approverId;
  var status;
  var modifiedBy;
  var commentRejection;
  var commentCancellation;

  bool selected = false;

  TrainingApproveListModel({
    this.tableName,
    this.documentType,
    this.requestCode,
    this.sequenceNo,
    this.senderId,
    this.employeeApproverId,
    this.approverId,
    this.status,
    this.modifiedBy,
    this.commentRejection,
    this.commentCancellation,
  });

  factory TrainingApproveListModel.fromJson(Map<String, dynamic> json) => TrainingApproveListModel(
    tableName: json["TableName"],
    documentType: json["DocumentType"],
    requestCode: json["RequestCode"],
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
    "RequestCode": requestCode,
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