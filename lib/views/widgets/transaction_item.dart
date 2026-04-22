import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/transaction_model.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback onDelete;

  const TransactionItem({
    super.key,
    required this.transaction,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionType.income;
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    final dateFormat = DateFormat('MMM dd, yyyy');

    Color iconBgColor;
    Color iconColor;
    IconData iconData;

    // Simple matching to simulate design
    if (transaction.title.toLowerCase().contains('food')) {
      iconBgColor = const Color(0xFFFFF3E0);
      iconColor = const Color(0xFFFFB74D);
      iconData = Icons.restaurant;
    } else if (transaction.title.toLowerCase().contains('salary')) {
      iconBgColor = const Color(0xFFE8F5E9);
      iconColor = const Color(0xFF81C784);
      iconData = Icons.attach_money;
    } else if (transaction.title.toLowerCase().contains('entertainment')) {
      iconBgColor = const Color(0xFFF3E5F5);
      iconColor = const Color(0xFFBA68C8);
      iconData = Icons.local_activity;
    } else {
      iconBgColor = isIncome ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE);
      iconColor = isIncome ? const Color(0xFF81C784) : const Color(0xFFE57373);
      iconData = isIncome ? Icons.arrow_downward : Icons.arrow_upward;
    }

    return Dismissible(
      key: Key(transaction.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(iconData, color: iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: const TextStyle(
                      color: Color(0xFF1E212D),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isIncome ? 'Bank Account' : 'Card', // Mocking subtitle for design
                    style: const TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${isIncome ? '' : '-'}${currencyFormat.format(transaction.amount)}',
                  style: const TextStyle(
                    color: Color(0xFF1E212D),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dateFormat.format(transaction.date),
                  style: const TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
