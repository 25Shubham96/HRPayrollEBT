import 'dart:convert';

FixedAssetResponse fixedAssetResponseFromJson(String str) =>
    FixedAssetResponse.fromJson(json.decode(str));

String fixedAssetResponseToJson(FixedAssetResponse data) =>
    json.encode(data.toJson());

class FixedAssetResponse {
  bool status;
  String message;
  List<FixedAssetModel> data;

  FixedAssetResponse({
    this.status,
    this.message,
    this.data,
  });

  factory FixedAssetResponse.fromJson(Map<String, dynamic> json) =>
      FixedAssetResponse(
        status: json["status"],
        message: json["message"],
        data: List<FixedAssetModel>.from(
            json["data"].map((x) => FixedAssetModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FixedAssetModel {
  String no;
  String description;
  String responsibleEmployee;
  String faClassCode;
  String faSubclassCode;
  String faLocationCode;
  int owner;
  String manufacturar;
  String model;
  String ownerName;
  String currentAssetLocation;
  int issued;
  String assetType;

  FixedAssetModel({
    this.no,
    this.description,
    this.responsibleEmployee,
    this.faClassCode,
    this.faSubclassCode,
    this.faLocationCode,
    this.owner,
    this.manufacturar,
    this.model,
    this.ownerName,
    this.currentAssetLocation,
    this.issued,
    this.assetType,
  });

  factory FixedAssetModel.fromJson(Map<String, dynamic> json) =>
      FixedAssetModel(
        no: json["No_"],
        description: json["Description"],
        responsibleEmployee: json["Responsible Employee"],
        faClassCode: json["FA Class Code"],
        faSubclassCode: json["FA Subclass Code"],
        faLocationCode: json["FA Location Code"],
        owner: json["Owner"],
        manufacturar: json["Manufacturar"],
        model: json["Model"],
        ownerName: json["Owner Name"],
        currentAssetLocation: json["Current Asset Location"],
        issued: json["Issued"],
        assetType: json["Asset Type"],
      );

  Map<String, dynamic> toJson() => {
        "No_": no,
        "Description": description,
        "Responsible Employee": responsibleEmployee,
        "FA Class Code": faClassCode,
        "FA Subclass Code": faSubclassCode,
        "FA Location Code": faLocationCode,
        "Owner": owner,
        "Manufacturar": manufacturar,
        "Model": model,
        "Owner Name": ownerName,
        "Current Asset Location": currentAssetLocation,
        "Issued": issued,
        "Asset Type": assetType,
      };
}
