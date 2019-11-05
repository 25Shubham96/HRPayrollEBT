import 'dart:convert';

PostRetentionRequest postRetentionRequestFromJson(String str) => PostRetentionRequest.fromJson(json.decode(str));

String postRetentionRequestToJson(PostRetentionRequest data) => json.encode(data.toJson());

class PostRetentionRequest {
  int action;
  String receiptDate;
  String transactionId;

  PostRetentionRequest({
    this.action,
    this.receiptDate,
    this.transactionId,
  });

  factory PostRetentionRequest.fromJson(Map<String, dynamic> json) => PostRetentionRequest(
    action: json["Action"],
    receiptDate: json["receipt_date"],
    transactionId: json["transaction_id"],
  );

  Map<String, dynamic> toJson() => {
    "Action": action,
    "receipt_date": receiptDate,
    "transaction_id": transactionId,
  };
}