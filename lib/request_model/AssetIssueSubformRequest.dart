import 'dart:convert';

AssetIssueSubformRequest assetIssueSubformRequestFromJson(String str) => AssetIssueSubformRequest.fromJson(json.decode(str));

String assetIssueSubformRequestToJson(AssetIssueSubformRequest data) => json.encode(data.toJson());

class AssetIssueSubformRequest {
  int action;
  String issueNo;
  String lineNo;
  String assetType;
  String assetNo;
  String assetName;
  String owner;
  String ownerName;
  String value;
  String manufacturer;
  String model;
  String currentAssetLocation;
  String postedPurchaseOrder;

  AssetIssueSubformRequest({
    this.action,
    this.issueNo,
    this.lineNo,
    this.assetType,
    this.assetNo,
    this.assetName,
    this.owner,
    this.ownerName,
    this.value,
    this.manufacturer,
    this.model,
    this.currentAssetLocation,
    this.postedPurchaseOrder,
  });

  factory AssetIssueSubformRequest.fromJson(Map<String, dynamic> json) => AssetIssueSubformRequest(
    action: json["Action"],
    issueNo: json["Issue_no"],
    lineNo: json["Line_no"],
    assetType: json["Asset_type"],
    assetNo: json["Asset_no"],
    assetName: json["Asset_name"],
    owner: json["Owner"],
    ownerName: json["Owner_name"],
    value: json["Value"],
    manufacturer: json["Manufacturer"],
    model: json["Model"],
    currentAssetLocation: json["Current_asset_location"],
    postedPurchaseOrder: json["Posted_purchase_order"],
  );

  Map<String, dynamic> toJson() => {
    "Action": action,
    "Issue_no": issueNo,
    "Line_no": lineNo,
    "Asset_type": assetType,
    "Asset_no": assetNo,
    "Asset_name": assetName,
    "Owner": owner,
    "Owner_name": ownerName,
    "Value": value,
    "Manufacturer": manufacturer,
    "Model": model,
    "Current_asset_location": currentAssetLocation,
    "Posted_purchase_order": postedPurchaseOrder,
  };
}