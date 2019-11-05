import 'dart:convert';

NavigateResponseDesigLocHistory navigateResponseDesigLocHistoryFromJson(
        String str) =>
    NavigateResponseDesigLocHistory.fromJson(json.decode(str));

String navigateResponseDesigLocHistoryToJson(
        NavigateResponseDesigLocHistory data) =>
    json.encode(data.toJson());

class NavigateResponseDesigLocHistory {
  bool status;
  String message;
  List<DesigLocModel> data;

  NavigateResponseDesigLocHistory({
    this.status,
    this.message,
    this.data,
  });

  factory NavigateResponseDesigLocHistory.fromJson(Map<String, dynamic> json) =>
      new NavigateResponseDesigLocHistory(
        status: json["status"],
        message: json["message"],
        data: new List<DesigLocModel>.from(
            json["data"].map((x) => DesigLocModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DesigLocModel {
  String employeeId;
  String fromDate;
  String toDate;
  String value;
  String uniqueDate;

  DesigLocModel({
    this.employeeId,
    this.fromDate,
    this.toDate,
    this.value,
    this.uniqueDate,
  });

  factory DesigLocModel.fromJson(Map<String, dynamic> json) =>
      new DesigLocModel(
        employeeId: json["Employee ID"],
        fromDate: json["From Date"],
        toDate: json["To Date"],
        value: json["Value"],
        uniqueDate: json["uniqueDate"],
      );

  Map<String, dynamic> toJson() => {
        "Employee ID": employeeId,
        "From Date": fromDate,
        "To Date": toDate,
        "Value": value,
        "uniqueDate": uniqueDate,
      };
}
