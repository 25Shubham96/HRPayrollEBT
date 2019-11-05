import 'dart:convert';

TrainingApprovalResponse trainingApprovalResponseFromJson(String str) =>
    TrainingApprovalResponse.fromJson(json.decode(str));

String trainingApprovalResponseToJson(TrainingApprovalResponse data) =>
    json.encode(data.toJson());

class TrainingApprovalResponse {
  bool status;
  String message;
  List<TrainingApprovalModel> data;

  TrainingApprovalResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TrainingApprovalResponse.fromJson(Map<String, dynamic> json) =>
      new TrainingApprovalResponse(
        status: json["status"],
        message: json["message"],
        data: new List<TrainingApprovalModel>.from(
            json["data"].map((x) => TrainingApprovalModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TrainingApprovalModel {
  int entryNo;
  String tableName;
  String documentType;
  String requestCode;
  int sequenceNo;
  String senderId;
  String employeeApproverId;
  String approverId;
  String status;
  String modifiedBy;
  String commentRejection;
  String commentCancellation;

  bool selected = false;

  TrainingApprovalModel({
    this.entryNo,
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

  factory TrainingApprovalModel.fromJson(Map<String, dynamic> json) =>
      new TrainingApprovalModel(
        entryNo: json["EntryNo"],
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
        "EntryNo": entryNo,
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
