import 'package:expense_tracker_machine_test/features/category/category_controller.dart';
import 'package:expense_tracker_machine_test/features/category/category_model.dart';
import 'package:expense_tracker_machine_test/features/category/category_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepositoryProvider = Provider((ref) => CategoryRepository());

final categoryProvider =
    StateNotifierProvider.autoDispose<CategoryController, CategoryModel>(
  (ref) {
    ref.onDispose(() {
      debugPrint('categoryProvider has been disposed successfully.');
    });
    return CategoryController(ref, ref.watch(categoryRepositoryProvider));
  },
  name: 'categoryController',
);
