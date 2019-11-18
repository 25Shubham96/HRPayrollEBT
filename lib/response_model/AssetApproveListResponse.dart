import 'dart:convert';

AssetApproveListResponse assetApproveListResponseFromJson(String str) =>
    AssetApproveListResponse.fromJson(json.decode(str));

String assetApproveListResponseToJson(AssetApproveListResponse data) =>
    json.encode(data.toJson());

class AssetApproveListResponse {
  bool status;
  String message;
  List<AssetApproveListModel> data;

  AssetApproveListResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AssetApproveListResponse.fromJson(Map<String, dynamic> json) =>
      AssetApproveListResponse(
        status: json["status"],
        message: json["message"],
        data: List<AssetApproveListModel>.from(
            json["data"].map((x) => AssetApproveListModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AssetApproveListModel {
  var tableName;
  var documentType;
  var requisitionNo;
  var sequenceNo;
  var senderId;
  var employeeApproverId;
  var approverId;
  var status;
  var modifiedBy;
  var commentRejection;
  var commentCancellation;
  var requisitionDate;

  bool selected = false;

  AssetApproveListModel({
    this.tableName,
    this.documentType,
    this.requisitionNo,
    this.sequenceNo,
    this.senderId,
    this.employeeApproverId,
    this.approverId,
    this.status,
    this.modifiedBy,
    this.commentRejection,
    this.commentCancellation,
    this.requisitionDate,
  });

  factory AssetApproveListModel.fromJson(Map<String, dynamic> json) =>
      AssetApproveListModel(
        tableName: json["TableName"],
        documentType: json["DocumentType"],
        requisitionNo: json["Requisition No_"],
        sequenceNo: json["SequenceNo"],
        senderId: json["SenderId"],
        employeeApproverId: json["EmployeeApproverId"],
        approverId: json["ApproverId"],
        status: json["Status"],
        modifiedBy: json["ModifiedBy"],
        commentRejection: json["CommentRejection"],
        commentCancellation: json["CommentCancellation"],
        requisitionDate: json["RequisitionDate"],
      );

  Map<String, dynamic> toJson() => {
        "TableName": tableName,
        "DocumentType": documentType,
        "Requisition No_": requisitionNo,
        "SequenceNo": sequenceNo,
        "SenderId": senderId,
        "EmployeeApproverId": employeeApproverId,
        "ApproverId": approverId,
        "Status": status,
        "ModifiedBy": modifiedBy,
        "CommentRejection": commentRejection,
        "CommentCancellation": commentCancellation,
        "RequisitionDate": requisitionDate,
      };
}
