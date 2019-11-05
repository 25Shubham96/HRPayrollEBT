import 'dart:convert';

TrainingProviderResponse trainingProviderResponseFromJson(String str) => TrainingProviderResponse.fromJson(json.decode(str));

String trainingProviderResponseToJson(TrainingProviderResponse data) => json.encode(data.toJson());

class TrainingProviderResponse {
  bool status;
  String message;
  List<TrainingProviderModel> data;

  TrainingProviderResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TrainingProviderResponse.fromJson(Map<String, dynamic> json) => TrainingProviderResponse(
    status: json["status"],
    message: json["message"],
    data: List<TrainingProviderModel>.from(json["data"].map((x) => TrainingProviderModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TrainingProviderModel {
  var providerNo;
  var providerName;
  var address1;
  var address2;
  var postCode;
  var city;
  var country;
  var phoneNo;
  var providerType;
  var employeeNo;

  TrainingProviderModel({
    this.providerNo,
    this.providerName,
    this.address1,
    this.address2,
    this.postCode,
    this.city,
    this.country,
    this.phoneNo,
    this.providerType,
    this.employeeNo,
  });

  factory TrainingProviderModel.fromJson(Map<String, dynamic> json) => TrainingProviderModel(
    providerNo: json["Provider No_"],
    providerName: json["Provider Name"],
    address1: json["Address 1"],
    address2: json["Address 2"],
    postCode: json["Post Code"],
    city: json["City"],
    country: json["Country"],
    phoneNo: json["Phone No_"],
    providerType: json["Provider Type"],
    employeeNo: json["Employee No_"],
  );

  Map<String, dynamic> toJson() => {
    "Provider No_": providerNo,
    "Provider Name": providerName,
    "Address 1": address1,
    "Address 2": address2,
    "Post Code": postCode,
    "City": city,
    "Country": country,
    "Phone No_": phoneNo,
    "Provider Type": providerType,
    "Employee No_": employeeNo,
  };
}