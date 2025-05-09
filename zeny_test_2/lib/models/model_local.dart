import 'package:hive/hive.dart';

part 'model_local.g.dart'; // This file will be generated by Hive

@HiveType(typeId: 0) // Ensure a unique typeId for Hive
class LocalModel extends HiveObject {
  @HiveField(0)
  int transactionId;

  @HiveField(1)
  int transactionDate;

  @HiveField(2)
  String transactionType;

  @HiveField(3)
  double transactionAmount;

  @HiveField(4)
  String transactionCategory;

  @HiveField(5)
  String transactionCurrency;

  @HiveField(6)
  String transactionName;

  @HiveField(7)
  bool isDelete;

  LocalModel({
    this.transactionId = 0,
    this.transactionDate = 0,
    this.transactionType = '',
    this.transactionAmount = 0.00,
    this.transactionCategory = '',
    this.transactionCurrency = '',
    this.transactionName = '',
    this.isDelete = false,
  });
}