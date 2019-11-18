import 'dart:convert';

AssetIssueSubformResponse assetIssueSubformResponseFromJson(String str) =>
    AssetIssueSubformResponse.fromJson(json.decode(str));

String assetIssueSubformResponseToJson(AssetIssueSubformResponse data) =>
    json.encode(data.toJson());

class AssetIssueSubformResponse {
  bool status;
  String message;
  List<AssetIssueSubformModel> data;

  AssetIssueSubformResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AssetIssueSubformResponse.fromJson(Map<String, dynamic> json) =>
      AssetIssueSubformResponse(
        status: json["status"],
        message: json["message"],
        data: List<AssetIssueSubformModel>.from(
            json["data"].map((x) => AssetIssueSubformModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AssetIssueSubformModel {
  var issueNo;
  int lineNo;
  var assetType;
  var assetNo;
  var assetName;
  var owner;
  double value;
  var manufacturar;
  var model;
  var ownerName;
  var currentAssetLocation;
  var postedPurchaseOrderNo;

  bool selected = false;

  AssetIssueSubformModel({
    this.issueNo,
    this.lineNo,
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
  });

  factory AssetIssueSubformModel.fromJson(Map<String, dynamic> json) =>
      AssetIssueSubformModel(
        issueNo: json["Issue No_"],
        lineNo: json["Line No_"],
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
      );

  Map<String, dynamic> toJson() => {
        "Issue No_": issueNo,
        "Line No_": lineNo,
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
      };
}
