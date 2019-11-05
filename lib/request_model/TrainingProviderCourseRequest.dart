import 'dart:convert';

TrainingProviderCourseRequest trainingCourseRequestFromJson(String str) => TrainingProviderCourseRequest.fromJson(json.decode(str));

String trainingCourseRequestToJson(TrainingProviderCourseRequest data) => json.encode(data.toJson());

class TrainingProviderCourseRequest {
  int action;

  TrainingProviderCourseRequest({
    this.action,
  });

  factory TrainingProviderCourseRequest.fromJson(Map<String, dynamic> json) => TrainingProviderCourseRequest(
    action: json["action"],
  );

  Map<String, dynamic> toJson() => {
    "action": action,
  };
}