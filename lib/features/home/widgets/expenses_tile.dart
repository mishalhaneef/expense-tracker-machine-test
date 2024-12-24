import 'package:expense_tracker_machine_test/constants/constants.dart';
import 'package:expense_tracker_machine_test/features/home/home_model.dart';
import 'package:expense_tracker_machine_test/features/home/home_provider.dart';
import 'package:expense_tracker_machine_test/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseTile extends ConsumerWidget {
  const ExpenseTile({
    super.key,
    required this.expenses,
    required this.index,
  });

  final ExpenseModel expenses;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(homeProvider.notifier);
    final date = expenses.date;

    return Padding(
      padding: const EdgeInsets.only(
        right: 16,
        left: 16,
        bottom: 16,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: Palatte.containerTheme,
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              expansionTileTheme: ExpansionTileThemeData(
                backgroundColor: Palatte.containerTheme,
                collapsedBackgroundColor: Palatte.containerTheme,
                tilePadding: tilePadding(),
              ),
            ),
            child: ExpansionTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 60,
                  child: Text(
                    "-₹${expenses.amount}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: Palatte.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: Text.rich(
                TextSpan(text: expenses.name),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                  '${notifier.fetchDay(date: date)} | ${notifier.formatTimeOfDay(expenses.time)}',
                  style: TextStyle(fontSize: 13)),
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(expenses.description ?? ''),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "-₹${expenses.amount}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: Palatte.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text('${expenses.category?.name}',
                        style: TextStyle(fontSize: 13)),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Expense'),
                              content: Text(
                                  "this action cannot be undone. Do you want to proceed?"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      overlayColor:
                                          WidgetStateProperty.all(Colors.white),
                                      backgroundColor:
                                          WidgetStateProperty.all(Palatte.red)),
                                  onPressed: () async {
                                    await notifier.deleteExpense(index);
                                    if (context.mounted) {
                                      NavigationHandler.pop(context);
                                    }
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsets tilePadding() {
    return const EdgeInsets.only(
      left: 5,
      right: 20,
      top: 5,
      bottom: 5,
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: Palatte.containerTheme,
      border: Border.all(color: Palatte.borderTheme, width: 1),
      borderRadius: BorderRadius.circular(15),
    );
  }
}
