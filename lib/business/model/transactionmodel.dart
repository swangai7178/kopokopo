class Transactions {
  String? transactionId;
  String? accountId;
  int? amount;
  String? createdAt;

  Transactions({
    this.transactionId,
    this.accountId,
    this.amount,
    this.createdAt,
  });

  Transactions.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'] as String?;
    accountId = json['account_id'] as String?;
    amount = json['amount'] as int?;
    createdAt = json['created_at'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['transaction_id'] = transactionId;
    json['account_id'] = accountId;
    json['amount'] = amount;
    json['created_at'] = createdAt;
    return json;
  }
}