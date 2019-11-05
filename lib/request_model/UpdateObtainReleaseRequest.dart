import 'dart:convert';

UpdateObtainReleaseRequest updateObtainReleaseRequestFromJson(String str) => UpdateObtainReleaseRequest.fromJson(json.decode(str));

String updateObtainReleaseRequestToJson(UpdateObtainReleaseRequest data) => json.encode(data.toJson());

class UpdateObtainReleaseRequest {
  String passportReleased;
  String passportObtained;
  String employeeId;

  UpdateObtainReleaseRequest({
    this.passportReleased,
    this.passportObtained,
    this.employeeId,
  });

  factory UpdateObtainReleaseRequest.fromJson(Map<String, dynamic> json) => UpdateObtainReleaseRequest(
    passportReleased: json["passportReleased"],
    passportObtained: json["passportObtained"],
    employeeId: json["employeeId"],
  );

  Map<String, dynamic> toJson() => {
    "passportReleased": passportReleased,
    "passportObtained": passportObtained,
    "employeeId": employeeId,
  };
}