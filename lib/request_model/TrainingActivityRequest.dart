import 'dart:convert';

TrainingActivityRequest trainingActivityRequestFromJson(String str) =>
    TrainingActivityRequest.fromJson(json.decode(str));

String trainingActivityRequestToJson(TrainingActivityRequest data) =>
    json.encode(data.toJson());

class TrainingActivityRequest {
  int action;
  String activityNo;
  String startDate;
  String startTime;
  String endDate;
  String endTime;
  String location;
  String providerId;
  String providerName;
  String courseId;
  String courseDescription;
  String joiningInstDoc;
  int status;

  TrainingActivityRequest({
    this.action,
    this.activityNo,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.location,
    this.providerId,
    this.providerName,
    this.courseId,
    this.courseDescription,
    this.joiningInstDoc,
    this.status,
  });

  factory TrainingActivityRequest.fromJson(Map<String, dynamic> json) =>
      TrainingActivityRequest(
        action: json["action"],
        activityNo: json["activity_no"],
        startDate: json["start_date"],
        startTime: json["start_time"],
        endDate: json["end_date"],
        endTime: json["end_time"],
        location: json["location"],
        providerId: json["provider_id"],
        providerName: json["provider_name"],
        courseId: json["course_id"],
        courseDescription: json["course_description"],
        joiningInstDoc: json["joining_inst_doc"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "activity_no": activityNo,
        "start_date": startDate,
        "start_time": startTime,
        "end_date": endDate,
        "end_time": endTime,
        "location": location,
        "provider_id": providerId,
        "provider_name": providerName,
        "course_id": courseId,
        "course_description": courseDescription,
        "joining_inst_doc": joiningInstDoc,
        "Status": status,
      };
}
