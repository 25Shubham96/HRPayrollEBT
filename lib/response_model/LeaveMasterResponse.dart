import 'dart:convert';

LeaveMasterResponse leaveMasterResponseFromJson(String str) =>
    LeaveMasterResponse.fromJson(json.decode(str));

String leaveMasterResponseToJson(LeaveMasterResponse data) =>
    json.encode(data.toJson());

class LeaveMasterResponse {
  bool status;
  String message;
  List<LeaveMasterModel> data;

  LeaveMasterResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LeaveMasterResponse.fromJson(Map<String, dynamic> json) =>
      LeaveMasterResponse(
        status: json["status"],
        message: json["message"],
        data: List<LeaveMasterModel>.from(
            json["data"].map((x) => LeaveMasterModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LeaveMasterModel {
  var leaveCode;
  var description;
  var noOfLeavesInYear;
  var creditingInterval;
  var creditingType;
  var minimumAllowed;
  var maximumAllowed;
  var carryForward;
  var applicableDate;
  var applicableForGrade;
  var maxLeavesToCarryForward;
  var applicableDuringProbation;
  var noOfLeavesDuringProbation;
  var encashable;
  var maxEncashable;
  var leaveTypeAsPerCompany;
  var status;
  var leaveForDays;
  var onlyOnceInEmploymentPeriod;
  var lossOfPay;

  bool selected = false;

  LeaveMasterModel({
    this.leaveCode,
    this.description,
    this.noOfLeavesInYear,
    this.creditingInterval,
    this.creditingType,
    this.minimumAllowed,
    this.maximumAllowed,
    this.carryForward,
    this.applicableDate,
    this.applicableForGrade,
    this.maxLeavesToCarryForward,
    this.applicableDuringProbation,
    this.noOfLeavesDuringProbation,
    this.encashable,
    this.maxEncashable,
    this.leaveTypeAsPerCompany,
    this.status,
    this.leaveForDays,
    this.onlyOnceInEmploymentPeriod,
    this.lossOfPay,
  });

  factory LeaveMasterModel.fromJson(Map<String, dynamic> json) =>
      LeaveMasterModel(
        leaveCode: json["Leave Code"],
        description: json["Description"],
        noOfLeavesInYear: json["No_ of Leaves in Year"],
        creditingInterval: json["Crediting Interval"],
        creditingType: json["Crediting Type"],
        minimumAllowed: json["Minimum Allowed"],
        maximumAllowed: json["Maximum Allowed"],
        carryForward: json["Carry Forward"],
        applicableDate: json["Applicable Date"],
        applicableForGrade: json["Applicable for Grade"],
        maxLeavesToCarryForward: json["Max_Leaves to Carry Forward"],
        applicableDuringProbation: json["Applicable During Probation"],
        noOfLeavesDuringProbation: json["No_of Leaves During Probation"],
        encashable: json["Encashable"],
        maxEncashable: json["Max_ Encashable"],
        leaveTypeAsPerCompany: json["Leave Type(As per Company)"],
        status: json["Status"],
        leaveForDays: json["Leave For Days"],
        onlyOnceInEmploymentPeriod: json["Only Once in Employment Period"],
        lossOfPay: json["Loss of Pay"],
      );

  Map<String, dynamic> toJson() => {
        "Leave Code": leaveCode,
        "Description": description,
        "No_ of Leaves in Year": noOfLeavesInYear,
        "Crediting Interval": creditingInterval,
        "Crediting Type": creditingType,
        "Minimum Allowed": minimumAllowed,
        "Maximum Allowed": maximumAllowed,
        "Carry Forward": carryForward,
        "Applicable Date": applicableDate,
        "Applicable for Grade": applicableForGrade,
        "Max_Leaves to Carry Forward": maxLeavesToCarryForward,
        "Applicable During Probation": applicableDuringProbation,
        "No_of Leaves During Probation": noOfLeavesDuringProbation,
        "Encashable": encashable,
        "Max_ Encashable": maxEncashable,
        "Leave Type(As per Company)": leaveTypeAsPerCompany,
        "Status": status,
        "Leave For Days": leaveForDays,
        "Only Once in Employment Period": onlyOnceInEmploymentPeriod,
        "Loss of Pay": lossOfPay,
      };
}
