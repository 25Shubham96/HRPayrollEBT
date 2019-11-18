import 'dart:convert';

IssueReturnLedgerRequest issueReturnLedgerRequestFromJson(String str) =>
    IssueReturnLedgerRequest.fromJson(json.decode(str));

String issueReturnLedgerRequestToJson(IssueReturnLedgerRequest data) =>
    json.encode(data.toJson());

class IssueReturnLedgerRequest {
  int action;
  String issueDate;
  String issueNo;
  int lineNo;

  IssueReturnLedgerRequest({
    this.action,
    this.issueDate,
    this.issueNo,
    this.lineNo,
  });

  factory IssueReturnLedgerRequest.fromJson(Map<String, dynamic> json) =>
      IssueReturnLedgerRequest(
        action: json["Action"],
        issueDate: json["issue_date"],
        issueNo: json["issue_no"],
        lineNo: json["line_no"],
      );

  Map<String, dynamic> toJson() => {
        "Action": action,
        "issue_date": issueDate,
        "issue_no": issueNo,
        "line_no": lineNo,
      };
}
