import 'dart:convert';

AssetReqSubformRequest assetReqSubformRequestFromJson(String str) =>
    AssetReqSubformRequest.fromJson(json.decode(str));

String assetReqSubformRequestToJson(AssetReqSubformRequest data) =>
    json.encode(data.toJson());

class AssetReqSubformRequest {
  var action;
  var requisitionNo;
  double quantity;
  var lineNo;
  var assetType;

  AssetReqSubformRequest({
    this.action,
    this.requisitionNo,
    this.quantity,
    this.lineNo,
    this.assetType,
  });

  factory AssetReqSubformRequest.fromJson(Map<String, dynamic> json) =>
      AssetReqSubformRequest(
        action: json["Action"],
        requisitionNo: json["Requisition_no"],
        quantity: json["Quantity"],
        lineNo: json["line_no"],
        assetType: json["asset_type"],
      );

  Map<String, dynamic> toJson() => {
        "Action": action,
        "Requisition_no": requisitionNo,
        "Quantity": quantity,
        "line_no": lineNo,
        "asset_type": assetType,
      };
}
