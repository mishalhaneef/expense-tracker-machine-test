import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:expense_tracker_machine_test/features/category/category_model.dart';

part 'home_model.g.dart';

class HomeModel {
  ExpenseModel? expenseModel;
  List<ExpenseModel?>? expenseList;
  Map<String, String>? validationErrors;
  HomeModel({
    this.expenseModel,
    this.validationErrors,
    this.expenseList,
  });

  HomeModel copyWith({
    ExpenseModel? expenseModel,
    List<ExpenseModel?>? expenseList,
    Map<String, String>? validationErrors,
  }) {
    return HomeModel(
      expenseModel: expenseModel ?? this.expenseModel,
      expenseList: expenseList ?? this.expenseList,
      validationErrors: validationErrors ?? this.validationErrors,
    );
  }
}

@HiveType(typeId: 0)
class ExpenseModel {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String? amount;

  @HiveField(3)
  CategoryModel? category;

  @HiveField(4)
  DateTime? date;

  @HiveField(5)
  TimeOfDay? time;

  ExpenseModel({
    this.name,
    this.description,
    this.amount,
    this.category,
    this.date,
    this.time,
  });

  ExpenseModel copyWith({
    String? name,
    String? description,
    String? amount,
    CategoryModel? category,
    DateTime? date,
    TimeOfDay? time,
  }) {
    return ExpenseModel(
      name: name ?? this.name,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }
}
