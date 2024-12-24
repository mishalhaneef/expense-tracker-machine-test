import 'package:expense_tracker_machine_test/constants/constants.dart';

import 'package:expense_tracker_machine_test/features/category/category_model.dart';
import 'package:expense_tracker_machine_test/features/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseFormField extends ConsumerWidget {
  const ExpenseFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(homeProvider);
    final notifier = ref.watch(homeProvider.notifier);
    final validationErrors = controller.validationErrors;

    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Expense Name',
            hintText: 'Enter expense name',
            filled: true,
            errorText: validationErrors?['expenseName'],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onChanged: notifier.updateExpenseName,
        ),
        SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Amount',
            hintText: 'Enter expense amount',
            errorText: validationErrors?['amount'],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onChanged: notifier.updateAmount,
        ),
        SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Description',
            hintText: 'Enter description',
            errorText: validationErrors?['description'],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onChanged: notifier.updateDescription,
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          onChanged: (value) {
            notifier.updateCategory(CategoryModel(name: value));
          },
          decoration: InputDecoration(
            labelText: 'Category',
            filled: true,
            errorText: validationErrors?['category'],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: listOfCategories
              .map<DropdownMenuItem<String>>((CategoryModel value) {
            return DropdownMenuItem<String>(
              value: value.name,
              child: Text(value.name ?? ''),
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );

            notifier.updateDate(selectedDate ?? DateTime.now());
          },
          child: AbsorbPointer(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Palatte.textFieldTheme,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    notifier.formatDate(controller.expenseModel?.date) ??
                        'Select Date',
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(
                    Icons.calendar_today,
                    color: Palatte.secondaryTheme,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            TimeOfDay? selectedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (selectedTime != null) {
              notifier.updateTime(selectedTime);
            } else {
              notifier.updateTime(TimeOfDay.now());
            }
          },
          child: AbsorbPointer(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Palatte.textFieldTheme,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    notifier.formatTimeOfDay(controller.expenseModel?.time) ??
                        'Choose Time',
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(
                    Icons.access_time,
                    color: Palatte.secondaryTheme,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
