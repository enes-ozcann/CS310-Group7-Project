import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../models/expense_model.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final String currency;
  final VoidCallback onRemove;
  final VoidCallback? onEdit;

  const ExpenseCard({
    super.key,
    required this.expense,
    this.currency = '€',
    required this.onRemove,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.cardBorder, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onEdit,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              // Category Icon inside colored container
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: expense.categoryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  expense.categoryIcon,
                  color: expense.categoryColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),

              // Title, Category • Date (Matches Figma Wireframe #6)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.title,
                      style: AppTextStyles.bodyBold.copyWith(fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${expense.categoryName} • ${expense.date}',
                      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                    ),
                    if (expense.notes != null && expense.notes!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        expense.notes!,
                        style: AppTextStyles.caption.copyWith(fontStyle: FontStyle.italic),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              // Price (Bold)
              Text(
                '$currency${expense.amount.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 4),

              // Edit Action (Matches Wireframe #12: Harcama Düzenleme)
              if (onEdit != null)
                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.textSecondary,
                    size: 18,
                  ),
                  onPressed: onEdit,
                  tooltip: 'Edit Expense',
                  splashRadius: 18,
                ),

              // Working Remove Action Button (Rubric Requirement 5)
              IconButton(
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.error,
                  size: 19,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (delCtx) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      title: const Text('Remove Expense?', style: AppTextStyles.heading3),
                      content: Text('Remove "${expense.title}" from this trip?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(delCtx),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(delCtx);
                            onRemove();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.error,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Remove'),
                        ),
                      ],
                    ),
                  );
                },
                tooltip: 'Remove Expense',
                splashRadius: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
