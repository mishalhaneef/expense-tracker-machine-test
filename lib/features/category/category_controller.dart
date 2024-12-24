import 'package:expense_tracker_machine_test/features/category/category_model.dart';
import 'package:expense_tracker_machine_test/features/category/category_repository.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryController extends StateNotifier<CategoryModel> {
  CategoryController(
    this.ref,
    this.repository,
  ) : super(CategoryModel());

  final CategoryRepository repository;
  final Ref ref;

  updateCategoryName(String categoryName) {
    state = state.copyWith();
  }

  createExpense() {}
}
