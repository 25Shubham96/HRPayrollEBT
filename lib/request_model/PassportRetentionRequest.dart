import 'dart:convert';

PassportRetentionRequest passportRetentionRequestFromJson(String str) =>
    PassportRetentionRequest.fromJson(json.decode(str));

String passportRetentionRequestToJson(PassportRetentionRequest data) =>
    json.encode(data.toJson());

class PassportRetentionRequest {
  int action;
  String transactionId;
  int requestType;
  String employeeId;
  String employeeName;
  String passportNo;
  String receivingEmployeeNo;
  String receivingEmployeeName;
  String receivingDate;
  String receivingTime;
  String comment;
  String transactionType;
  String expectedColDate;
  String empDepartment;
  String returnDate;
  String userId;
  int status;

  PassportRetentionRequest({
    this.action,
    this.transactionId,
    this.requestType,
    this.employeeId,
    this.employeeName,
    this.passportNo,
    this.receivingEmployeeNo,
    this.receivingEmployeeName,
    this.receivingDate,
    this.receivingTime,
    this.comment,
    this.transactionType,
    this.expectedColDate,
    this.empDepartment,
    this.returnDate,
    this.userId,
    this.status,
  });

  factory PassportRetentionRequest.fromJson(Map<String, dynamic> json) =>
      PassportRetentionRequest(
        action: json["Action"],
        transactionId: json["transaction_id"],
        requestType: json["request_type"],
        employeeId: json["employee_id"],
        employeeName: json["employee_name"],
        passportNo: json["passport_no"],
        receivingEmployeeNo: json["receiving_employee_no"],
        receivingEmployeeName: json["receiving_employee_name"],
        receivingDate: json["receiving_date"],
        receivingTime: json["receiving_time"],
        comment: json["comment"],
        transactionType: json["transaction_type"],
        expectedColDate: json["expected_col_date"],
        empDepartment: json["emp_department"],
        returnDate: json["return_date"],
        userId: json["user_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "Action": action,
        "transaction_id": transactionId,
        "request_type": requestType,
        "employee_id": employeeId,
        "employee_name": employeeName,
        "passport_no": passportNo,
        "receiving_employee_no": receivingEmployeeNo,
        "receiving_employee_name": receivingEmployeeName,
        "receiving_date": receivingDate,
        "receiving_time": receivingTime,
        "comment": comment,
        "transaction_type": transactionType,
        "expected_col_date": expectedColDate,
        "emp_department": empDepartment,
        "return_date": returnDate,
        "user_id": userId,
        "status": status,
      };
}
