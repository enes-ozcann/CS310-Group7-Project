import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class BudgetSummaryCard extends StatelessWidget {
  final double totalBudget;
  final double totalSpent;
  final double remaining;
  final String currency;
  final VoidCallback onEditBudget;

  const BudgetSummaryCard({
    super.key,
    required this.totalBudget,
    required this.totalSpent,
    required this.remaining,
    this.currency = '€',
    required this.onEditBudget,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = totalBudget > 0 ? (totalSpent / totalBudget).clamp(0.0, 1.0) : 0.0;
    final int percentInt = (percentage * 100).round();

    Color statusColor = AppColors.success;
    String statusText = 'Budget Healthy';

    if (totalSpent > totalBudget) {
      statusColor = AppColors.error;
      statusText = 'Budget Exceeded!';
    } else if (percentage >= 0.8) {
      statusColor = AppColors.warning;
      statusText = 'Near Budget Limit';
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.account_balance_wallet_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Budget Overview', style: AppTextStyles.heading3),
                        Text(
                          'Financial tracking & allocation',
                          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 3 Stat Tiles
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    title: 'TOTAL',
                    value: '$currency${totalBudget.toStringAsFixed(0)}',
                    color: AppColors.textPrimary,
                    trailingIcon: Icons.edit_rounded,
                    onTap: onEditBudget,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildMetricTile(
                    title: 'SPENT',
                    value: '$currency${totalSpent.toStringAsFixed(0)}',
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildMetricTile(
                    title: 'REMAINING',
                    value: '$currency${remaining.toStringAsFixed(0)}',
                    color: remaining < 0 ? AppColors.error : AppColors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Progress Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Budget Utilization', style: AppTextStyles.caption),
                Text(
                  '$percentInt%',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: percentage,
                minHeight: 8,
                backgroundColor: AppColors.cardBorder,
                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile({
    required String title,
    required String value,
    required Color color,
    IconData? trailingIcon,
    VoidCallback? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: AppColors.textMuted,
                ),
              ),
              if (trailingIcon != null)
                GestureDetector(
                  onTap: onTap,
                  child: Icon(trailingIcon, size: 12, color: AppColors.primary),
                ),
            ],
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

