import 'dart:convert';

TrainingReqRequest trainingReqRequestFromJson(String str) =>
    TrainingReqRequest.fromJson(json.decode(str));

String trainingReqRequestToJson(TrainingReqRequest data) =>
    json.encode(data.toJson());

class TrainingReqRequest {
  int action;
  String requestNo;
  String requestedBy;
  String department;
  String contactNo;
  String contactName;
  String requestType;
  String trainingCourse;
  String trainingCourseTitle;
  String comment;
  int status;

  TrainingReqRequest({
    this.action,
    this.requestNo,
    this.requestedBy,
    this.department,
    this.contactNo,
    this.contactName,
    this.requestType,
    this.trainingCourse,
    this.trainingCourseTitle,
    this.comment,
    this.status,
  });

  factory TrainingReqRequest.fromJson(Map<String, dynamic> json) =>
      TrainingReqRequest(
        action: json["action"],
        requestNo: json["request_no"],
        requestedBy: json["requested_by"],
        department: json["department"],
        contactNo: json["contact_no"],
        contactName: json["contact_name"],
        requestType: json["request_type"],
        trainingCourse: json["training_course"],
        trainingCourseTitle: json["training_course_title"],
        comment: json["comment"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "request_no": requestNo,
        "requested_by": requestedBy,
        "department": department,
        "contact_no": contactNo,
        "contact_name": contactName,
        "request_type": requestType,
        "training_course": trainingCourse,
        "training_course_title": trainingCourseTitle,
        "comment": comment,
        "status": status,
      };
}
