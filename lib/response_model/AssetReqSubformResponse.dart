import 'dart:convert';

AssetReqSubformResponse assetReqSubformResponseFromJson(String str) =>
    AssetReqSubformResponse.fromJson(json.decode(str));

String assetReqSubformResponseToJson(AssetReqSubformResponse data) =>
    json.encode(data.toJson());

class AssetReqSubformResponse {
  bool status;
  String message;
  List<AssetReqSubformModel> data;

  AssetReqSubformResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AssetReqSubformResponse.fromJson(Map<String, dynamic> json) =>
      AssetReqSubformResponse(
        status: json["status"],
        message: json["message"],
        data: List<AssetReqSubformModel>.from(
            json["data"].map((x) => AssetReqSubformModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AssetReqSubformModel {
  var requisitionNo;
  var lineNo;
  var assetType;
  double quantity;

  bool selected = false;

  AssetReqSubformModel({
    this.requisitionNo,
    this.lineNo,
    this.assetType,
    this.quantity,
  });

  factory AssetReqSubformModel.fromJson(Map<String, dynamic> json) =>
      AssetReqSubformModel(
        requisitionNo: json["Requisition No_"],
        lineNo: json["Line No_"],
        assetType: json["Asset Type"],
        quantity: json["Quantity"],
      );

  Map<String, dynamic> toJson() => {
        "Requisition No_": requisitionNo,
        "Line No_": lineNo,
        "Asset Type": assetType,
        "Quantity": quantity,
      };
}
