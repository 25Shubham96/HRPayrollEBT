import 'dart:convert';

TrainingActivitySubformResponse trainingActivitySubformResponseFromJson(String str) => TrainingActivitySubformResponse.fromJson(json.decode(str));

String trainingActivitySubformResponseToJson(TrainingActivitySubformResponse data) => json.encode(data.toJson());

class TrainingActivitySubformResponse {
  bool status;
  String message;
  List<TrainingActivitySubformModel> data;

  TrainingActivitySubformResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TrainingActivitySubformResponse.fromJson(Map<String, dynamic> json) => TrainingActivitySubformResponse(
    status: json["status"],
    message: json["message"],
    data: List<TrainingActivitySubformModel>.from(json["data"].map((x) => TrainingActivitySubformModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TrainingActivitySubformModel {
  var activityNo;
  var employeeNo;
  var employeeName;
  int planned;
  int attended;
  int certificateIssued;
  var departmentCode;
  int confirmationAssessmentFilled;
  var comments;

  bool selected = false;

  TrainingActivitySubformModel({
    this.activityNo,
    this.employeeNo,
    this.employeeName,
    this.planned,
    this.attended,
    this.certificateIssued,
    this.departmentCode,
    this.confirmationAssessmentFilled,
    this.comments,
  });

  factory TrainingActivitySubformModel.fromJson(Map<String, dynamic> json) => TrainingActivitySubformModel(
    activityNo: json["Activity No_"],
    employeeNo: json["Employee No_"],
    employeeName: json["Employee Name"],
    planned: json["Planned"],
    attended: json["Attended"],
    certificateIssued: json["Certificate Issued"],
    departmentCode: json["Department Code"],
    confirmationAssessmentFilled: json["Confirmation_Assessment filled"],
    comments: json["Comments"],
  );

  Map<String, dynamic> toJson() => {
    "Activity No_": activityNo,
    "Employee No_": employeeNo,
    "Employee Name": employeeName,
    "Planned": planned,
    "Attended": attended,
    "Certificate Issued": certificateIssued,
    "Department Code": departmentCode,
    "Confirmation_Assessment filled": confirmationAssessmentFilled,
    "Comments": comments,
  };
}