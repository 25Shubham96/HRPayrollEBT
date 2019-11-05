import 'dart:convert';

NavigateResponseCarryFwdInfo navigateResponseCarryFwdInfoFromJson(String str) =>
    NavigateResponseCarryFwdInfo.fromJson(json.decode(str));

String navigateResponseCarryFwdInfoToJson(NavigateResponseCarryFwdInfo data) =>
    json.encode(data.toJson());

class NavigateResponseCarryFwdInfo {
  bool status;
  String message;
  List<CarryFwdInfoModel> data;

  NavigateResponseCarryFwdInfo({
    this.status,
    this.message,
    this.data,
  });

  factory NavigateResponseCarryFwdInfo.fromJson(Map<String, dynamic> json) =>
      new NavigateResponseCarryFwdInfo(
        status: json["status"],
        message: json["message"],
        data: new List<CarryFwdInfoModel>.from(
            json["data"].map((x) => CarryFwdInfoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CarryFwdInfoModel {
  String employeeNo;
  int carryForwardToYear;
  String startDate;
  int carryForwardLeave;
  String remarks;
  String uniqueDate;

  CarryFwdInfoModel({
    this.employeeNo,
    this.carryForwardToYear,
    this.startDate,
    this.carryForwardLeave,
    this.remarks,
    this.uniqueDate,
  });

  factory CarryFwdInfoModel.fromJson(Map<String, dynamic> json) =>
      new CarryFwdInfoModel(
        employeeNo: json["Employee No"],
        carryForwardToYear: json["Carry Forward to Year"],
        startDate: json["Start Date"],
        carryForwardLeave: json["Carry Forward Leave"],
        remarks: json["Remarks"],
        uniqueDate: json["UniqueDate"],
      );

  Map<String, dynamic> toJson() => {
        "Employee No": employeeNo,
        "Carry Forward to Year": carryForwardToYear,
        "Start Date": startDate,
        "Carry Forward Leave": carryForwardLeave,
        "Remarks": remarks,
        "UniqueDate": uniqueDate,
      };
}
