import 'dart:convert';

ClosedTrainingListResponse closedTrainingListResponseFromJson(String str) =>
    ClosedTrainingListResponse.fromJson(json.decode(str));

String closedTrainingListResponseToJson(ClosedTrainingListResponse data) =>
    json.encode(data.toJson());

class ClosedTrainingListResponse {
  bool status;
  String message;
  List<ClosedTrainingListModel> data;

  ClosedTrainingListResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ClosedTrainingListResponse.fromJson(Map<String, dynamic> json) =>
      ClosedTrainingListResponse(
        status: json["status"],
        message: json["message"],
        data: List<ClosedTrainingListModel>.from(
            json["data"].map((x) => ClosedTrainingListModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ClosedTrainingListModel {
  var activityNo;
  var trainingLocation;
  var status;
  var trainingProvider;
  var courseId;
  var courseStartDate;
  var courseEndDate;
  var trainingProviderName;
  var courseDescription;

  ClosedTrainingListModel({
    this.activityNo,
    this.trainingLocation,
    this.status,
    this.trainingProvider,
    this.courseId,
    this.courseStartDate,
    this.courseEndDate,
    this.trainingProviderName,
    this.courseDescription,
  });

  factory ClosedTrainingListModel.fromJson(Map<String, dynamic> json) =>
      ClosedTrainingListModel(
        activityNo: json["Activity No_"],
        trainingLocation: json["Training Location"],
        status: json["Status"],
        trainingProvider: json["Training Provider"],
        courseId: json["Course ID"],
        courseStartDate: json["Course Start Date"],
        courseEndDate: json["Course End Date"],
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
        "Course End Date": courseEndDate,
        "Training Provider Name": trainingProviderName,
        "Course Description": courseDescription,
      };
}
