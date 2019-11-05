import 'dart:convert';

NavigateResponsePayElements navigateResponsePayElementsFromJson(String str) =>
    NavigateResponsePayElements.fromJson(json.decode(str));

String navigateResponsePayElementsToJson(NavigateResponsePayElements data) =>
    json.encode(data.toJson());

class NavigateResponsePayElements {
  bool status;
  String message;
  List<PayElementsModel> data;

  NavigateResponsePayElements({
    this.status,
    this.message,
    this.data,
  });

  factory NavigateResponsePayElements.fromJson(Map<String, dynamic> json) =>
      new NavigateResponsePayElements(
        status: json["status"],
        message: json["message"],
        data: new List<PayElementsModel>.from(
            json["data"].map((x) => PayElementsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PayElementsModel {
  String employeeCode;
  String effectiveStartDate;
  String payElementCode;
  String fixedPercent;
  String addDeduct;
  double amountPercent;
  String computationType;
  String payCadre;
  var applicableForOt;
  String uniqueDate;

  PayElementsModel({
    this.employeeCode,
    this.effectiveStartDate,
    this.payElementCode,
    this.fixedPercent,
    this.addDeduct,
    this.amountPercent,
    this.computationType,
    this.payCadre,
    this.applicableForOt,
    this.uniqueDate,
  });

  factory PayElementsModel.fromJson(Map<String, dynamic> json) =>
      new PayElementsModel(
        employeeCode: json["Employee Code"],
        effectiveStartDate: json["Effective Start Date"],
        payElementCode: json["Pay Element Code"],
        fixedPercent: json["Fixed_Percent"],
        addDeduct: json["Add_Deduct"],
        amountPercent: json["Amount _ Percent"].toDouble(),
        computationType: json["Computation Type"],
        payCadre: json["Pay Cadre"],
        applicableForOt: json["Applicable for OT"],
        uniqueDate: json["UniqueDate"],
      );

  Map<String, dynamic> toJson() => {
        "Employee Code": employeeCode,
        "Effective Start Date": effectiveStartDate,
        "Pay Element Code": payElementCode,
        "Fixed_Percent": fixedPercent,
        "Add_Deduct": addDeduct,
        "Amount _ Percent": amountPercent,
        "Computation Type": computationType,
        "Pay Cadre": payCadre,
        "Applicable for OT": applicableForOt,
        "UniqueDate": uniqueDate,
      };
}
