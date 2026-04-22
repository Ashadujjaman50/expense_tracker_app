import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker_app/main.dart';
import 'package:expense_tracker_app/view_models/transaction_view_model.dart';

void main() {
  testWidgets('Expense tracker app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TransactionViewModel()),
        ],
        child: const ExpenseTrackerApp(),
      ),
    );

    // Verify that our app starts and shows the title.
    expect(find.text('Expense Tracker'), findsWidgets);
  });
}
