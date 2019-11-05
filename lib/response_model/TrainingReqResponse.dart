import 'dart:convert';

TrainingReqResponse trainingReqResponseFromJson(String str) => TrainingReqResponse.fromJson(json.decode(str));

String trainingReqResponseToJson(TrainingReqResponse data) => json.encode(data.toJson());

class TrainingReqResponse {
  bool status;
  String message;
  List<TrainingRequestModel> data;

  TrainingReqResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TrainingReqResponse.fromJson(Map<String, dynamic> json) => TrainingReqResponse(
    status: json["status"],
    message: json["message"],
    data: List<TrainingRequestModel>.from(json["data"].map((x) => TrainingRequestModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TrainingRequestModel {
  var requestNo;
  var requestedBy;
  var contactNo;
  var requestType;
  var trainingCourseTitle;
  var comments;
  var contactName;
  var trainingCourse;
  var status;
  var department;

  bool selected = false;

  TrainingRequestModel({
    this.requestNo,
    this.requestedBy,
    this.contactNo,
    this.requestType,
    this.trainingCourseTitle,
    this.comments,
    this.contactName,
    this.trainingCourse,
    this.status,
    this.department,
  });

  factory TrainingRequestModel.fromJson(Map<String, dynamic> json) => TrainingRequestModel(
    requestNo: json["Request No_"],
    requestedBy: json["Requested By"],
    contactNo: json["Contact No_"],
    requestType: json["Request Type"],
    trainingCourseTitle: json["Training Course Title"],
    comments: json["Comments"],
    contactName: json["Contact Name"],
    trainingCourse: json["Training Course"],
    status: json["Status"],
    department: json["Department"],
  );

  Map<String, dynamic> toJson() => {
    "Request No_": requestNo,
    "Requested By": requestedBy,
    "Contact No_": contactNo,
    "Request Type": requestType,
    "Training Course Title": trainingCourseTitle,
    "Comments": comments,
    "Contact Name": contactName,
    "Training Course": trainingCourse,
    "Status": status,
    "Department": department,
  };
}
