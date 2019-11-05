import 'dart:convert';

IssueReturnLedgerResponse issueReturnLedgerResponseFromJson(String str) => IssueReturnLedgerResponse.fromJson(json.decode(str));

String issueReturnLedgerResponseToJson(IssueReturnLedgerResponse data) => json.encode(data.toJson());

class IssueReturnLedgerResponse {
  bool status;
  String message;
  List<IssueReturnLedgerModel> data;

  IssueReturnLedgerResponse({
    this.status,
    this.message,
    this.data,
  });

  factory IssueReturnLedgerResponse.fromJson(Map<String, dynamic> json) => IssueReturnLedgerResponse(
    status: json["status"],
    message: json["message"],
    data: List<IssueReturnLedgerModel>.from(json["data"].map((x) => IssueReturnLedgerModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class IssueReturnLedgerModel {
  var issueNo;
  var employeeNo;
  var issuedBy;
  var issued;
  var issueDate;
  var returned;
  var returnDate;
  var assetType;
  var assetNo;
  var assetName;
  var owner;
  var value;
  var manufacturar;
  var model;
  var ownerName;
  var currentAssetLocation;
  var postedPurchaseOrderNo;
  var issuedReturned;

  IssueReturnLedgerModel({
    this.issueNo,
    this.employeeNo,
    this.issuedBy,
    this.issued,
    this.issueDate,
    this.returned,
    this.returnDate,
    this.assetType,
    this.assetNo,
    this.assetName,
    this.owner,
    this.value,
    this.manufacturar,
    this.model,
    this.ownerName,
    this.currentAssetLocation,
    this.postedPurchaseOrderNo,
    this.issuedReturned,
  });

  factory IssueReturnLedgerModel.fromJson(Map<String, dynamic> json) => IssueReturnLedgerModel(
    issueNo: json["Issue No_"],
    employeeNo: json["Employee No_"],
    issuedBy: json["Issued By"],
    issued: json["Issued"],
    issueDate: json["Issue Date"],
    returned: json["Returned"],
    returnDate: json["Return Date"],
    assetType: json["Asset Type"],
    assetNo: json["Asset No_"],
    assetName: json["Asset Name"],
    owner: json["Owner"],
    value: json["Value"],
    manufacturar: json["Manufacturar"],
    model: json["Model"],
    ownerName: json["Owner Name"],
    currentAssetLocation: json["Current Asset Location"],
    postedPurchaseOrderNo: json["Posted Purchase Order No_"],
    issuedReturned: json["Issued & Returned"],
  );

  Map<String, dynamic> toJson() => {
    "Issue No_": issueNo,
    "Employee No_": employeeNo,
    "Issued By": issuedBy,
    "Issued": issued,
    "Issue Date": issueDate,
    "Returned": returned,
    "Return Date": returnDate,
    "Asset Type": assetType,
    "Asset No_": assetNo,
    "Asset Name": assetName,
    "Owner": owner,
    "Value": value,
    "Manufacturar": manufacturar,
    "Model": model,
    "Owner Name": ownerName,
    "Current Asset Location": currentAssetLocation,
    "Posted Purchase Order No_": postedPurchaseOrderNo,
    "Issued & Returned": issuedReturned,
  };
}