import 'dart:convert';

NavigateResponseKRA navigateResponseKRAFromJson(String str) =>
    NavigateResponseKRA.fromJson(json.decode(str));

String navigateResponseKRAToJson(NavigateResponseKRA data) =>
    json.encode(data.toJson());

class NavigateResponseKRA {
  bool status;
  String message;
  List<KRAModel> data;

  NavigateResponseKRA({
    this.status,
    this.message,
    this.data,
  });

  factory NavigateResponseKRA.fromJson(Map<String, dynamic> json) =>
      new NavigateResponseKRA(
        status: json["status"],
        message: json["message"],
        data: new List<KRAModel>.from(
            json["data"].map((x) => KRAModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class KRAModel {
  String employeeCode;
  String applicablePeriodFromDate;
  String applicablePeriodToDate;
  int kraCode;
  String kraDescription;
  double weightage;
  String targetUnits;
  double target;
  String targerType;
  String uniqueDate;

  KRAModel({
    this.employeeCode,
    this.applicablePeriodFromDate,
    this.applicablePeriodToDate,
    this.kraCode,
    this.kraDescription,
    this.weightage,
    this.targetUnits,
    this.target,
    this.targerType,
    this.uniqueDate,
  });

  factory KRAModel.fromJson(Map<String, dynamic> json) => new KRAModel(
        employeeCode: json["Employee Code"],
        applicablePeriodFromDate: json["Applicable Period From Date"],
        applicablePeriodToDate: json["Applicable Period To Date"],
        kraCode: json["KRA Code"],
        kraDescription: json["KRA Description"],
        weightage: json["Weightage"],
        targetUnits: json["Target Units"],
        target: json["Target"],
        targerType: json["Targer Type"],
        uniqueDate: json["uniqueDate"],
      );

  Map<String, dynamic> toJson() => {
        "Employee Code": employeeCode,
        "Applicable Period From Date": applicablePeriodFromDate,
        "Applicable Period To Date": applicablePeriodToDate,
        "KRA Code": kraCode,
        "KRA Description": kraDescription,
        "Weightage": weightage,
        "Target Units": targetUnits,
        "Target": target,
        "Targer Type": targerType,
        "uniqueDate": uniqueDate,
      };
}
