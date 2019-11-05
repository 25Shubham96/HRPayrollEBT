import 'dart:convert';

LeaveApprovalResponse leaveApprovalResponseFromJson(String str) =>
    LeaveApprovalResponse.fromJson(json.decode(str));

String leaveApprovalResponseToJson(LeaveApprovalResponse data) =>
    json.encode(data.toJson());

class LeaveApprovalResponse {
  bool status;
  String message;
  List<LeaveApprovalModel> data;

  LeaveApprovalResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LeaveApprovalResponse.fromJson(Map<String, dynamic> json) =>
      new LeaveApprovalResponse(
        status: json["status"],
        message: json["message"],
        data: new List<LeaveApprovalModel>.from(
            json["data"].map((x) => LeaveApprovalModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LeaveApprovalModel {
  int documentNo;
  int entryNo;
  String tableName;
  String documentType;
  String documentCode;
  int sequenceNo;
  String senderId;
  String employeeApproverId;
  String approverId;
  String status;
  String fromDate;
  String toDate;
  String modifiedBy;
  String commentRejection;
  String commentCancellation;
  String uniqueDate;
  String column1;
  String hashCode1;
  String hashCode2;

  bool selected = false;

  LeaveApprovalModel({
    this.documentNo,
    this.entryNo,
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
    this.uniqueDate,
    this.column1,
    this.hashCode1,
    this.hashCode2,
  });

  factory LeaveApprovalModel.fromJson(Map<String, dynamic> json) =>
      new LeaveApprovalModel(
        documentNo: json["DocumentNo"],
        entryNo: json["EntryNo"],
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
        uniqueDate: json["UniqueDate"],
        column1: json["Column1"],
        hashCode1: json["HashCode1"],
        hashCode2: json["HashCode2"],
      );

  Map<String, dynamic> toJson() => {
        "DocumentNo": documentNo,
        "EntryNo": entryNo,
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
        "UniqueDate": uniqueDate,
        "Column1": column1,
        "HashCode1": hashCode1,
        "HashCode2": hashCode2,
      };
}
