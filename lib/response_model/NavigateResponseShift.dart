import 'dart:convert';

NavigateResponseShift navigateResponseShiftFromJson(String str) =>
    NavigateResponseShift.fromJson(json.decode(str));

String navigateResponseShiftToJson(NavigateResponseShift data) =>
    json.encode(data.toJson());

class NavigateResponseShift {
  bool status;
  String message;
  List<ShiftModel> data;

  NavigateResponseShift({
    this.status,
    this.message,
    this.data,
  });

  factory NavigateResponseShift.fromJson(Map<String, dynamic> json) =>
      new NavigateResponseShift(
        status: json["status"],
        message: json["message"],
        data: new List<ShiftModel>.from(
            json["data"].map((x) => ShiftModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ShiftModel {
  String employeeCode;
  String startDate;
  String shiftCode;
  String dd;

  ShiftModel({
    this.employeeCode,
    this.startDate,
    this.shiftCode,
    this.dd,
  });

  factory ShiftModel.fromJson(Map<String, dynamic> json) => new ShiftModel(
        employeeCode: json["Employee Code"],
        startDate: json["Start Date"],
        shiftCode: json["Shift Code"],
        dd: json["dd"],
      );

  Map<String, dynamic> toJson() => {
        "Employee Code": employeeCode,
        "Start Date": startDate,
        "Shift Code": shiftCode,
        "dd": dd,
      };
}
