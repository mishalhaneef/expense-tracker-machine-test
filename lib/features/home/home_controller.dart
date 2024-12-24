import 'package:expense_tracker_machine_test/constants/enums.dart';
import 'package:expense_tracker_machine_test/core/handler.dart';
import 'package:expense_tracker_machine_test/features/category/category_model.dart';
import 'package:expense_tracker_machine_test/features/home/home_model.dart';
import 'package:expense_tracker_machine_test/features/home/home_repository.dart';
import 'package:expense_tracker_machine_test/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HomeController extends StateNotifier<HomeModel> {
  HomeController(
    this.ref,
    this.repository,
  ) : super(HomeModel(expenseModel: ExpenseModel())) {
    fetchDay();
    fetchExpenses();
  }

  final HomeRepository repository;
  final Ref ref;

  void fetchExpenses() {
    final expenseBox = Hive.box<ExpenseModel>(HiveBoxKeys.expenses.name);
    List<ExpenseModel> expenseList = expenseBox.values.toList();
    state =
        state.copyWith(expenseModel: ExpenseModel(), expenseList: expenseList);
  }

  void updateExpenseName(String expenseName) {
    state = state.copyWith(
      expenseModel: state.expenseModel?.copyWith(name: expenseName),
    );
  }

  void updateAmount(String amount) {
    state = state.copyWith(
      expenseModel: state.expenseModel?.copyWith(amount: amount),
    );
  }

  void updateDescription(String description) {
    state = state.copyWith(
      expenseModel: state.expenseModel?.copyWith(description: description),
    );
  }

  void updateCategory(CategoryModel? category) {
    state = state.copyWith(
      expenseModel: state.expenseModel?.copyWith(category: category),
    );
  }

  void updateDate(DateTime? date) {
    state = state.copyWith(
      expenseModel: state.expenseModel?.copyWith(
        date: date ?? DateTime.now(),
      ),
    );
  }

  void updateTime(TimeOfDay? time) {
    state = state.copyWith(
      expenseModel: state.expenseModel?.copyWith(
        time: time ?? TimeOfDay.now(),
      ),
    );
  }

  void clearState() {
    state = state.copyWith(expenseModel: ExpenseModel());
  }

  void setValidationError(Map<String, String>? errors) {
    state = state.copyWith(
      validationErrors: errors,
    );
  }

  Future<void> createExpense(BuildContext context) async {
    final validation = validateFields();
    if (validation != null) {
      setValidationError(validation.errors);
      return;
    }

    final expenseBox = Hive.box<ExpenseModel>(HiveBoxKeys.expenses.name);
    final expense = state.expenseModel;

    if (expense != null) {
      await expenseBox.add(expense);

      final updatedExpenseList =
          List<ExpenseModel>.from(state.expenseList ?? []);
      updatedExpenseList.add(expense);

      state = state.copyWith(
        expenseList: updatedExpenseList,
      );
      if (context.mounted) {
        NavigationHandler.pop(context);
      }
    }

    setValidationError({});
  }

  Future<void> deleteExpense(int index) async {
    final expenseBox = Hive.box<ExpenseModel>(HiveBoxKeys.expenses.name);

    await expenseBox.deleteAt(index);

    final updatedExpenseList = List<ExpenseModel>.from(state.expenseList ?? []);
    updatedExpenseList.removeAt(index);

    state = state.copyWith(expenseList: updatedExpenseList);
  }

  String fetchDay({DateTime? date}) {
    final now = DateTime.now();
    String formatter = DateFormat('EEEE').format(date ?? now);
    return formatter;
  }

  String fetchTime({DateTime? date}) {
    final now = DateFormat('hh:mm a').format(date ?? DateTime.now());
    return now;
  }

  String? formatDate(DateTime? date) {
    if (date != null) {
      final day = date.day.toString().padLeft(2, '0');
      final month = date.month.toString().padLeft(2, '0');
      final year = date.year.toString();
      return '$day/$month/$year';
    } else {
      return null;
    }
  }

  String? formatTimeOfDay(TimeOfDay? time) {
    if (time != null) {
      final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      final minute = time.minute.toString().padLeft(2, '0');
      final period = time.period == DayPeriod.am ? 'AM' : 'PM';
      return '$hour:$minute $period';
    } else {
      return null;
    }
  }

  double getTotalExpensesForToday() {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    // final todayEnd =
    //     DateTime(now.year, now.month, now.day, 23, 59, 59, 999); // End of today

    final expensesToday = state.expenseList?.where((expense) {
          final isToday = expense!.date != null && expense.date == todayStart;

          return isToday;
        }).toList() ??
        [];

    double total = 0;
    for (var expense in expensesToday) {
      if (expense!.amount != null && expense.amount!.isNotEmpty) {
        final parsedAmount = double.tryParse(expense.amount!);
        if (parsedAmount != null) {
          total += parsedAmount;
        } else {}
      }
    }

    return total;
  }

  double getTotalExpensesForThisMonth() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    // final endOfMonth = DateTime(now.year, now.month + 1, 0);

    final expensesThisMonth = state.expenseList?.where((expense) {
          final expenseDate = expense?.date;
          if (expenseDate != null) {
            final isThisMonth = expenseDate.year == startOfMonth.year &&
                expenseDate.month == startOfMonth.month;

            if (isThisMonth) {}
            return isThisMonth;
          }
          return false;
        }).toList() ??
        [];

    double total = 0;
    for (var expense in expensesThisMonth) {
      if (expense?.amount != null && expense!.amount!.isNotEmpty) {
        final parsedAmount = double.tryParse(expense.amount!);
        if (parsedAmount != null) {
          total += parsedAmount;
        } else {}
      }
    }

    return total;
  }

  void sortExpensesByDateAndTime() {
    final updatedExpenseList = List<ExpenseModel>.from(state.expenseList ?? []);

    updatedExpenseList.sort((a, b) {
      final dateComparison = a.date!.compareTo(b.date!);
      if (dateComparison != 0) {
        return dateComparison;
      }

      final timeA = TimeOfDay(hour: a.time!.hour, minute: a.time!.minute);
      final timeB = TimeOfDay(hour: b.time!.hour, minute: b.time!.minute);
      return timeA.hour.compareTo(timeB.hour) != 0
          ? timeA.hour.compareTo(timeB.hour)
          : timeA.minute.compareTo(timeB.minute);
    });

    state = state.copyWith(expenseList: updatedExpenseList);
  }

  ValidationError? validateFields() {
    final errors = <String, String>{};

    final expenseName = state.expenseModel?.name;
    if (expenseName == null || expenseName.isEmpty) {
      errors['expenseName'] = 'Expense name is required.';
    }
    final amount = state.expenseModel?.amount;
    if (amount == null || amount.isEmpty) {
      errors['amount'] = 'Amount is required.';
    }

    return null;
  }
}
