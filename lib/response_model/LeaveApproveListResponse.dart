import 'dart:convert';

LeaveApproveListResponse leaveApproveListResponseFromJson(String str) =>
    LeaveApproveListResponse.fromJson(json.decode(str));

String leaveApproveListResponseToJson(LeaveApproveListResponse data) =>
    json.encode(data.toJson());

class LeaveApproveListResponse {
  bool status;
  String message;
  List<LeaveApproveListModel> data;

  LeaveApproveListResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LeaveApproveListResponse.fromJson(Map<String, dynamic> json) =>
      LeaveApproveListResponse(
        status: json["status"],
        message: json["message"],
        data: List<LeaveApproveListModel>.from(
            json["data"].map((x) => LeaveApproveListModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LeaveApproveListModel {
  var tableName;
  var documentType;
  var documentCode;
  var sequenceNo;
  var senderId;
  var employeeApproverId;
  var approverId;
  var status;
  var fromDate;
  var toDate;
  var modifiedBy;
  var commentRejection;
  var commentCancellation;
  var documentNo;

  bool selected = false;

  LeaveApproveListModel({
    this.tableName,
    this.documentType,
    this.documentCode,
    this.sequenceNo,
    this.senderId,
    this.employeeApproverId,
    this.approverId,
    this.status,
    this.fromDate,
    this.toDate,
    this.modifiedBy,
    this.commentRejection,
    this.commentCancellation,
    this.documentNo,
  });

  factory LeaveApproveListModel.fromJson(Map<String, dynamic> json) =>
      LeaveApproveListModel(
        tableName: json["TableName"],
        documentType: json["DocumentType"],
        documentCode: json["DocumentCode"],
        sequenceNo: json["SequenceNo"],
        senderId: json["SenderId"],
        employeeApproverId: json["EmployeeApproverId"],
        approverId: json["ApproverId"],
        status: json["Status"],
        fromDate: json["FromDate"],
        toDate: json["ToDate"],
        modifiedBy: json["ModifiedBy"],
        commentRejection: json["CommentRejection"],
        commentCancellation: json["CommentCancellation"],
        documentNo: json["DocumentNo"],
      );

  Map<String, dynamic> toJson() => {
        "TableName": tableName,
        "DocumentType": documentType,
        "DocumentCode": documentCode,
        "SequenceNo": sequenceNo,
        "SenderId": senderId,
        "EmployeeApproverId": employeeApproverId,
        "ApproverId": approverId,
        "Status": status,
        "FromDate": fromDate,
        "ToDate": toDate,
        "ModifiedBy": modifiedBy,
        "CommentRejection": commentRejection,
        "CommentCancellation": commentCancellation,
        "DocumentNo": documentNo,
      };
}
