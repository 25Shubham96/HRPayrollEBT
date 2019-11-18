import 'dart:convert';

TrainingActivityResponse trainingActivityResponseFromJson(String str) =>
    TrainingActivityResponse.fromJson(json.decode(str));

String trainingActivityResponseToJson(TrainingActivityResponse data) =>
    json.encode(data.toJson());

class TrainingActivityResponse {
  bool status;
  String message;
  List<TrainingActivityModel> data;

  TrainingActivityResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TrainingActivityResponse.fromJson(Map<String, dynamic> json) =>
      TrainingActivityResponse(
        status: json["status"],
        message: json["message"],
        data: List<TrainingActivityModel>.from(
            json["data"].map((x) => TrainingActivityModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TrainingActivityModel {
  var activityNo;
  var trainingLocation;
  var status;
  var trainingProvider;
  var courseId;
  var courseStartDate;
  var courseStartTime;
  var courseEndDate;
  var courseEndTime;
  var joiningInstructionDocument;
  var trainingProviderName;
  var courseDescription;

  bool selected = false;

  TrainingActivityModel({
    this.activityNo,
    this.trainingLocation,
    this.status,
    this.trainingProvider,
    this.courseId,
    this.courseStartDate,
    this.courseStartTime,
    this.courseEndDate,
    this.courseEndTime,
    this.joiningInstructionDocument,
    this.trainingProviderName,
    this.courseDescription,
  });

  factory TrainingActivityModel.fromJson(Map<String, dynamic> json) =>
      TrainingActivityModel(
        activityNo: json["Activity No_"],
        trainingLocation: json["Training Location"],
        status: json["Status"],
        trainingProvider: json["Training Provider"],
        courseId: json["Course ID"],
        courseStartDate: json["Course Start Date"],
        courseStartTime: json["Course Start Time"],
        courseEndDate: json["Course End Date"],
        courseEndTime: json["Course End Time"],
        joiningInstructionDocument: json["Joining Instruction Document"],
        trainingProviderName: json["Training Provider Name"],
        courseDescription: json["Course Description"],
      );

  Map<String, dynamic> toJson() => {
        "Activity No_": activityNo,
        "Training Location": trainingLocation,
        "Status": status,
        "Training Provider": trainingProvider,
        "Course ID": courseId,
        "Course Start Date": courseStartDate,
        "Course Start Time": courseStartTime,
        "Course End Date": courseEndDate,
        "Course End Time": courseEndTime,
        "Joining Instruction Document": joiningInstructionDocument,
        "Training Provider Name": trainingProviderName,
        "Course Description": courseDescription,
      };
}
