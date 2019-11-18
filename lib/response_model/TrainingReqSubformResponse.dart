import 'dart:convert';

TrainingReqSubformResponse trainingReqSubformResponseFromJson(String str) =>
    TrainingReqSubformResponse.fromJson(json.decode(str));

String trainingReqSubformResponseToJson(TrainingReqSubformResponse data) =>
    json.encode(data.toJson());

class TrainingReqSubformResponse {
  bool status;
  String message;
  List<TrainingReqSubformModel> data;

  TrainingReqSubformResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TrainingReqSubformResponse.fromJson(Map<String, dynamic> json) =>
      TrainingReqSubformResponse(
        status: json["status"],
        message: json["message"],
        data: List<TrainingReqSubformModel>.from(
            json["data"].map((x) => TrainingReqSubformModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TrainingReqSubformModel {
  var requestNo;
  var lineNo;
  var employeeNo;
  var employeeName;

  bool selected = false;

  TrainingReqSubformModel({
    this.requestNo,
    this.lineNo,
    this.employeeNo,
    this.employeeName,
  });

  factory TrainingReqSubformModel.fromJson(Map<String, dynamic> json) =>
      TrainingReqSubformModel(
        requestNo: json["Request No_"],
        lineNo: json["Line No_"],
        employeeNo: json["Employee No_"],
        employeeName: json["Employee Name"],
      );

  Map<String, dynamic> toJson() => {
        "Request No_": requestNo,
        "Line No_": lineNo,
        "Employee No_": employeeNo,
        "Employee Name": employeeName,
      };
}
