import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/transaction_view_model.dart';

import 'widgets/dashboard_card.dart';
import 'widgets/transaction_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello,',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF7A7A7A),
                        ),
                      ),
                      Text(
                        'Ashadujjaman',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E212D),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: Color(0xFF1E212D),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            // Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  _buildChip('All', isSelected: true),
                  _buildChip('Daily'),
                  _buildChip('Weekly'),
                  _buildChip('Monthly'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Dashboard Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Consumer<TransactionViewModel>(
                builder: (context, viewModel, _) {
                  return DashboardCard(
                    totalIncome: viewModel.totalIncome,
                    totalExpense: viewModel.totalExpense,
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            // Recent Transactions Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent transactions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E212D),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF7A7A7A),
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.chevron_right,
                          size: 14,
                          color: Color(0xFF7A7A7A),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // List
            Expanded(
              child: Consumer<TransactionViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.transactions.isEmpty) {
                    return const Center(child: Text('No transactions yet.'));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    itemCount: viewModel.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction =
                          viewModel.transactions[viewModel.transactions.length -
                              1 -
                              index];
                      return TransactionItem(
                        transaction: transaction,
                        onDelete: () {
                          viewModel.deleteTransaction(transaction.id);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.transparent : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? const Color(0xFF1E212D) : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? const Color(0xFF1E212D) : const Color(0xFF7A7A7A),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}
