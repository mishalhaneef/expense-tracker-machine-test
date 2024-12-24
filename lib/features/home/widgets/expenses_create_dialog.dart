import 'package:expense_tracker_machine_test/features/home/home_provider.dart';
import 'package:expense_tracker_machine_test/features/home/widgets/expense_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showCreateExpenseDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Expense'),
        content: SingleChildScrollView(
          child: ExpenseFormField(),
        ),
        actions: <Widget>[
          Consumer(
            builder: (context, ref, child) {
              final homeProviderWatch = ref.watch(homeProvider.notifier);

              return TextButton(
                onPressed: () {
                  homeProviderWatch.clearState();
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final homeProviderWatch = ref.watch(homeProvider.notifier);

              return ElevatedButton(
                style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(Colors.white),
                    backgroundColor: WidgetStateProperty.all(Colors.white)),
                onPressed: () async {
                  await homeProviderWatch.createExpense(context);
                },
                child: Text(
                  'Create',
                  style: TextStyle(color: Colors.black),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}
