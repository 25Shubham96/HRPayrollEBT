import 'dart:convert';

AssetReqResponse assetReqResponseFromJson(String str) =>
    AssetReqResponse.fromJson(json.decode(str));

String assetReqResponseToJson(AssetReqResponse data) =>
    json.encode(data.toJson());

class AssetReqResponse {
  bool status;
  String message;
  List<AssetReqModel> data;

  AssetReqResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AssetReqResponse.fromJson(Map<String, dynamic> json) =>
      AssetReqResponse(
        status: json["status"],
        message: json["message"],
        data: List<AssetReqModel>.from(
            json["data"].map((x) => AssetReqModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AssetReqModel {
  var requisitionNo;
  var employeeNo;
  var employeeName;
  var requisionDate;
  var requestedBy;
  var requestedByName;
  var status;
  var department;
  var userId;

  bool selected = false;

  AssetReqModel({
    this.requisitionNo,
    this.employeeNo,
    this.employeeName,
    this.requisionDate,
    this.requestedBy,
    this.requestedByName,
    this.status,
    this.department,
    this.userId,
  });

  factory AssetReqModel.fromJson(Map<String, dynamic> json) => AssetReqModel(
        requisitionNo: json["Requisition No_"],
        employeeNo: json["Employee No_"],
        employeeName: json["Employee Name"],
        requisionDate: json["Requision Date"],
        requestedBy: json["Requested By"],
        requestedByName: json["Requested By Name"],
        status: json["Status"],
        department: json["Department"],
        userId: json["User Id"],
      );

  Map<String, dynamic> toJson() => {
        "Requisition No_": requisitionNo,
        "Employee No_": employeeNo,
        "Employee Name": employeeName,
        "Requision Date": requisionDate,
        "Requested By": requestedBy,
        "Requested By Name": requestedByName,
        "Status": status,
        "Department": department,
        "User Id": userId,
      };
}
