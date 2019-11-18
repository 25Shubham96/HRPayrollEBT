import 'dart:convert';

PassportRetentionResponse passportRetentionResponseFromJson(String str) =>
    PassportRetentionResponse.fromJson(json.decode(str));

String passportRetentionResponseToJson(PassportRetentionResponse data) =>
    json.encode(data.toJson());

class PassportRetentionResponse {
  bool status;
  String message;
  List<PassportRetentionModel> data;

  PassportRetentionResponse({
    this.status,
    this.message,
    this.data,
  });

  factory PassportRetentionResponse.fromJson(Map<String, dynamic> json) =>
      PassportRetentionResponse(
        status: json["status"],
        message: json["message"],
        data: List<PassportRetentionModel>.from(
            json["data"].map((x) => PassportRetentionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PassportRetentionModel {
  var dateOfReceipt;
  var transactionId;
  var requestType;
  var employeeId;
  var employeeName;
  var passportNo;
  var status;
  var receivingEmployeeId;
  var column1;
  var commentRemarks;
  var receivingEmployeeName;
  var transactionType;
  var noSeries;
  var employeeDepartment;
  var userId;
  var expectedReceiptDate;

  bool selected = false;

  PassportRetentionModel({
    this.dateOfReceipt,
    this.transactionId,
    this.requestType,
    this.employeeId,
    this.employeeName,
    this.passportNo,
    this.status,
    this.receivingEmployeeId,
    this.column1,
    this.commentRemarks,
    this.receivingEmployeeName,
    this.transactionType,
    this.noSeries,
    this.employeeDepartment,
    this.userId,
    this.expectedReceiptDate,
  });

  factory PassportRetentionModel.fromJson(Map<String, dynamic> json) =>
      PassportRetentionModel(
        dateOfReceipt: json["Date of Receipt"],
        transactionId: json["Transaction ID"],
        requestType: json["Request Type"],
        employeeId: json["Employee ID"],
        employeeName: json["Employee Name"],
        passportNo: json["Passport No_"],
        status: json["Status"],
        receivingEmployeeId: json["Receiving Employee ID"],
        column1: json["Column1"],
        commentRemarks: json["Comment_Remarks"],
        receivingEmployeeName: json["Receiving Employee Name"],
        transactionType: json["Transaction Type"],
        noSeries: json["No_ Series"],
        employeeDepartment: json["Employee Department"],
        userId: json["User ID"],
        expectedReceiptDate: json["Expected Receipt Date"],
      );

  Map<String, dynamic> toJson() => {
        "Date of Receipt": dateOfReceipt,
        "Transaction ID": transactionId,
        "Request Type": requestType,
        "Employee ID": employeeId,
        "Employee Name": employeeName,
        "Passport No_": passportNo,
        "Status": status,
        "Receiving Employee ID": receivingEmployeeId,
        "Column1": column1,
        "Comment_Remarks": commentRemarks,
        "Receiving Employee Name": receivingEmployeeName,
        "Transaction Type": transactionType,
        "No_ Series": noSeries,
        "Employee Department": employeeDepartment,
        "User ID": userId,
        "Expected Receipt Date": expectedReceiptDate,
      };
}
