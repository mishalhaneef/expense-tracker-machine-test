import 'package:expense_tracker_machine_test/features/category/category_model.dart';
import 'package:expense_tracker_machine_test/features/category/widget/category_create_widget.dart';
import 'package:expense_tracker_machine_test/features/category/widget/category_tile.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showCreateCategoryDialog(context);
        },
        tooltip: 'Create Category',
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return CategoryTile(
            category: listOfCategories[index],
          );
        },
      ),
    );
  }
}
