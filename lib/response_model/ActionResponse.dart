import 'dart:convert';

ActionResponse actionResFromJson(String str) =>
    ActionResponse.fromJson(json.decode(str));

String actionResToJson(ActionResponse data) => json.encode(data.toJson());

class ActionResponse {
  bool status;
  String message;
  List<ActionResponseModel> data;

  ActionResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ActionResponse.fromJson(Map<String, dynamic> json) =>
      new ActionResponse(
        status: json["status"],
        message: json["message"],
        data: new List<ActionResponseModel>.from(
            json["data"].map((x) => ActionResponseModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ActionResponseModel {
  String employeeId;
  String sanctioningIncharge;
  int hierarchy;
  String inchargeName;
  String uniqueSactionIncharge;
  int uniqueHierachy;

  bool selected = false;

  ActionResponseModel({
    this.employeeId,
    this.sanctioningIncharge,
    this.hierarchy,
    this.inchargeName,
    this.uniqueSactionIncharge,
    this.uniqueHierachy,
  });

  factory ActionResponseModel.fromJson(Map<String, dynamic> json) =>
      new ActionResponseModel(
        employeeId: json["Employee ID"],
        sanctioningIncharge: json["Sanctioning Incharge"],
        hierarchy: json["Hierarchy"],
        inchargeName: json["Incharge Name"],
        uniqueSactionIncharge: json["UniqueSactionIncharge"],
        uniqueHierachy: json["UniqueHierachy"],
      );

  Map<String, dynamic> toJson() => {
        "Employee ID": employeeId,
        "Sanctioning Incharge": sanctioningIncharge,
        "Hierarchy": hierarchy,
        "Incharge Name": inchargeName,
        "UniqueSactionIncharge": uniqueSactionIncharge,
        "UniqueHierachy": uniqueHierachy,
      };
}
