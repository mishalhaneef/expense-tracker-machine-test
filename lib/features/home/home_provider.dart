import 'package:expense_tracker_machine_test/features/home/home_controller.dart';
import 'package:expense_tracker_machine_test/features/home/home_model.dart';
import 'package:expense_tracker_machine_test/features/home/home_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRepositoryProvider = Provider((ref) => HomeRepository());

final homeProvider =
    StateNotifierProvider.autoDispose<HomeController, HomeModel>(
  (ref) {
    ref.onDispose(() {
      debugPrint('HomeProvider has been disposed successfully.');
    });
    return HomeController(ref, ref.watch(homeRepositoryProvider));
  },
  name: 'HomeController',
);
