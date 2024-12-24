import 'package:expense_tracker_machine_test/constants/constants.dart';
import 'package:expense_tracker_machine_test/constants/enums.dart';
import 'package:expense_tracker_machine_test/features/category/category_model.dart';
import 'package:expense_tracker_machine_test/features/home/home_model.dart';
import 'package:expense_tracker_machine_test/features/home/home_screen.dart';
import 'package:expense_tracker_machine_test/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ExpenseModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());

  await Hive.openBox<ExpenseModel>(HiveBoxKeys.expenses.name);

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppTheme.appBarTheme,
        colorScheme: darkColorScheme,
        scaffoldBackgroundColor: Palatte.theme,
        dividerTheme: AppTheme.dividerTheme,
        useMaterial3: true,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: const HomePage(),
    );
  }
}
