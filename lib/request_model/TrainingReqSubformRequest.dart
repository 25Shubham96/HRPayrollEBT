import 'dart:convert';

TrainingReqSubformRequest trainingReqSubformRequestFromJson(String str) =>
    TrainingReqSubformRequest.fromJson(json.decode(str));

String trainingReqSubformRequestToJson(TrainingReqSubformRequest data) =>
    json.encode(data.toJson());

class TrainingReqSubformRequest {
  String action;
  String requestNo;
  String lineNo;
  String employeeNo;
  String employeeName;

  TrainingReqSubformRequest({
    this.action,
    this.requestNo,
    this.lineNo,
    this.employeeNo,
    this.employeeName,
  });

  factory TrainingReqSubformRequest.fromJson(Map<String, dynamic> json) =>
      TrainingReqSubformRequest(
        action: json["action"],
        requestNo: json["request_no"],
        lineNo: json["line_no"],
        employeeNo: json["employee_no"],
        employeeName: json["employee_name"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "request_no": requestNo,
        "line_no": lineNo,
        "employee_no": employeeNo,
        "employee_name": employeeName,
      };
}
