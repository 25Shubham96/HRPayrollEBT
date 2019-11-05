import 'dart:convert';

TrainingActivitySubformRequest trainingActivitySubformRequestFromJson(String str) => TrainingActivitySubformRequest.fromJson(json.decode(str));

String trainingActivitySubformRequestToJson(TrainingActivitySubformRequest data) => json.encode(data.toJson());

class TrainingActivitySubformRequest {
  int action;
  String activityNo;
  String employeeNo;
  String employeeName;
  int planned;
  int attended;
  int certificateIssued;
  String department;
  int confAssementFilled;
  String comment;

  TrainingActivitySubformRequest({
    this.action,
    this.activityNo,
    this.employeeNo,
    this.employeeName,
    this.planned,
    this.attended,
    this.certificateIssued,
    this.department,
    this.confAssementFilled,
    this.comment,
  });

  factory TrainingActivitySubformRequest.fromJson(Map<String, dynamic> json) => TrainingActivitySubformRequest(
    action: json["action"],
    activityNo: json["activity_no"],
    employeeNo: json["employee_no"],
    employeeName: json["employee_name"],
    planned: json["planned"],
    attended: json["attended"],
    certificateIssued: json["certificate_issued"],
    department: json["department"],
    confAssementFilled: json["conf_assement_filled"],
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "action": action,
    "activity_no": activityNo,
    "employee_no": employeeNo,
    "employee_name": employeeName,
    "planned": planned,
    "attended": attended,
    "certificate_issued": certificateIssued,
    "department": department,
    "conf_assement_filled": confAssementFilled,
    "comment": comment,
  };
}