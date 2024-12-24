import 'package:expense_tracker_machine_test/constants/enums.dart';
import 'package:expense_tracker_machine_test/features/category/category_screen.dart';
import 'package:expense_tracker_machine_test/features/home/home_model.dart';
import 'package:expense_tracker_machine_test/features/home/home_provider.dart';
import 'package:expense_tracker_machine_test/features/home/widgets/expenses_create_dialog.dart';
import 'package:expense_tracker_machine_test/features/home/widgets/expenses_summary_widget.dart';
import 'package:expense_tracker_machine_test/features/home/widgets/expenses_tile.dart';
import 'package:expense_tracker_machine_test/features/summery/summery_screen.dart';
import 'package:expense_tracker_machine_test/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(homeProvider.notifier);
    final controller = ref.watch(homeProvider);
    final today = notifier.fetchDay();
    final categoryEnum = PopupMenuOption.category.name;
    final summeryEnum = PopupMenuOption.summery.name;

    return Scaffold(
      appBar: AppBar(
        title: Text(today),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == summeryEnum) {
                NavigationHandler.navigateTo(context, SummeryScreen());
              } else if (value == categoryEnum) {
                NavigationHandler.navigateTo(context, CategoryScreen());
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: summeryEnum,
                  child: Text("Summery"),
                ),
                PopupMenuItem(
                  value: categoryEnum,
                  child: Text("Category"),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ExpensesSummaryWidget(),
          ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.expenseList?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              if (controller.expenseList?[index] != null) {
                return ExpenseTile(
                  expenses: controller.expenseList?[index] ?? ExpenseModel(),
                  index: index,
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showCreateExpenseDialog(context);
        },
        tooltip: 'Add Expenses',
        child: Icon(Icons.add),
      ),
    );
  }
}
