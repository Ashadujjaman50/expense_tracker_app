import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardCard extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;

  const DashboardCard({
    super.key,
    required this.totalIncome,
    required this.totalExpense,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 0);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatItem(
                'Income',
                currencyFormat.format(totalIncome),
                const Color(0xFFB5D8A6),
              ),
              const SizedBox(height: 24),
              _buildStatItem(
                'Spent',
                currencyFormat.format(totalExpense),
                const Color(0xFFF29B9B),
              ),
            ],
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 30,
                sections: [
                  if (totalIncome == 0 && totalExpense == 0)
                    PieChartSectionData(
                      color: Colors.grey.shade300,
                      value: 1,
                      title: '',
                      radius: 20,
                    )
                  else ...[
                    PieChartSectionData(
                      color: const Color(0xFFB5D8A6),
                      value: totalIncome,
                      title: '',
                      radius: 20,
                    ),
                    PieChartSectionData(
                      color: const Color(0xFFF29B9B),
                      value: totalExpense,
                      title: '',
                      radius: 20,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String amount, Color indicatorColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 12,
              decoration: BoxDecoration(
                color: indicatorColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF7A7A7A),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: const TextStyle(
            color: Color(0xFF1E212D),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
