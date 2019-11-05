import 'dart:convert';

PassportRetentionLedgerResponse passportRetentionLedgerResponseFromJson(String str) => PassportRetentionLedgerResponse.fromJson(json.decode(str));

String passportRetentionLedgerResponseToJson(PassportRetentionLedgerResponse data) => json.encode(data.toJson());

class PassportRetentionLedgerResponse {
  bool status;
  String message;
  List<PassportRetentionLedgerModel> data;

  PassportRetentionLedgerResponse({
    this.status,
    this.message,
    this.data,
  });

  factory PassportRetentionLedgerResponse.fromJson(Map<String, dynamic> json) => PassportRetentionLedgerResponse(
    status: json["status"],
    message: json["message"],
    data: List<PassportRetentionLedgerModel>.from(json["data"].map((x) => PassportRetentionLedgerModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PassportRetentionLedgerModel {
  var dateOfReceipt;
  var transactionId;
  var requestType;
  var employeeId;
  var employeeName;
  var passportNo;
  var receivingEmployeeId;
  var receivingEmployeeName;
  var dateOfReceipt1;
  var column1;
  var commentRemarks;
  var transactionType;
  var noSeries;
  var obtained;
  var released;
  var expectedReceiptDate;

  PassportRetentionLedgerModel({
    this.dateOfReceipt,
    this.transactionId,
    this.requestType,
    this.employeeId,
    this.employeeName,
    this.passportNo,
    this.receivingEmployeeId,
    this.receivingEmployeeName,
    this.dateOfReceipt1,
    this.column1,
    this.commentRemarks,
    this.transactionType,
    this.noSeries,
    this.obtained,
    this.released,
    this.expectedReceiptDate,
  });

  factory PassportRetentionLedgerModel.fromJson(Map<String, dynamic> json) => PassportRetentionLedgerModel(
    dateOfReceipt: json["Date of Receipt"],
    transactionId: json["Transaction ID"],
    requestType: json["Request Type"],
    employeeId: json["Employee ID"],
    employeeName: json["Employee Name"],
    passportNo: json["Passport No_"],
    receivingEmployeeId: json["Receiving Employee ID"],
    receivingEmployeeName: json["Receiving Employee Name"],
    dateOfReceipt1: json["Date of Receipt1"],
    column1: json["Column1"],
    commentRemarks: json["Comment_Remarks"],
    transactionType: json["Transaction Type"],
    noSeries: json["No_ Series"],
    obtained: json["Obtained"],
    released: json["Released"],
    expectedReceiptDate: json["Expected Receipt Date"],
  );

  Map<String, dynamic> toJson() => {
    "Date of Receipt": dateOfReceipt,
    "Transaction ID": transactionId,
    "Request Type": requestType,
    "Employee ID": employeeId,
    "Employee Name": employeeName,
    "Passport No_": passportNo,
    "Receiving Employee ID": receivingEmployeeId,
    "Receiving Employee Name": receivingEmployeeName,
    "Date of Receipt1": dateOfReceipt1,
    "Column1": column1,
    "Comment_Remarks": commentRemarks,
    "Transaction Type": transactionType,
    "No_ Series": noSeries,
    "Obtained": obtained,
    "Released": released,
    "Expected Receipt Date": expectedReceiptDate,
  };
}