import 'dart:convert';

TrainingCourseResponse trainingCourseResponseFromJson(String str) => TrainingCourseResponse.fromJson(json.decode(str));

String trainingCourseResponseToJson(TrainingCourseResponse data) => json.encode(data.toJson());

class TrainingCourseResponse {
  bool status;
  String message;
  List<TrainingCourseModel> data;

  TrainingCourseResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TrainingCourseResponse.fromJson(Map<String, dynamic> json) => TrainingCourseResponse(
    status: json["status"],
    message: json["message"],
    data: List<TrainingCourseModel>.from(json["data"].map((x) => TrainingCourseModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TrainingCourseModel {
  var courseId;
  var courseName;
  var category;
  var trainingType;
  var resultType;
  var result;
  var duration;
  var trainingCost;
  var courseDescription;
  var courseDocumentAttachment;

  TrainingCourseModel({
    this.courseId,
    this.courseName,
    this.category,
    this.trainingType,
    this.resultType,
    this.result,
    this.duration,
    this.trainingCost,
    this.courseDescription,
    this.courseDocumentAttachment,
  });

  factory TrainingCourseModel.fromJson(Map<String, dynamic> json) => TrainingCourseModel(
    courseId: json["Course ID"],
    courseName: json["Course Name"],
    category: json["Category"],
    trainingType: json["Training Type"],
    resultType: json["Result Type"],
    result: json["Result"],
    duration: json["Duration"],
    trainingCost: json["Training Cost"],
    courseDescription: json["Course Description"],
    courseDocumentAttachment: json["Course Document  Attachment"],
  );

  Map<String, dynamic> toJson() => {
    "Course ID": courseId,
    "Course Name": courseName,
    "Category": category,
    "Training Type": trainingType,
    "Result Type": resultType,
    "Result": result,
    "Duration": duration,
    "Training Cost": trainingCost,
    "Course Description": courseDescription,
    "Course Document  Attachment": courseDocumentAttachment,
  };
}