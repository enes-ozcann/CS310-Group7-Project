import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../models/expense_model.dart';
import '../../../models/trip_model.dart';
import '../widgets/add_expense_dialog.dart';
import '../widgets/budget_summary_card.dart';
import '../widgets/expense_card.dart';

class BudgetTab extends StatefulWidget {
  final Trip trip;

  const BudgetTab({super.key, required this.trip});

  @override
  State<BudgetTab> createState() => _BudgetTabState();
}

class _BudgetTabState extends State<BudgetTab> {
  ExpenseCategory? _filterCategory; // null = all

  void _openAddExpenseModal() {
    showDialog(
      context: context,
      builder: (ctx) => AddExpenseDialog(
        currency: widget.trip.currency,
        onExpenseSaved: (newExpense) {
          setState(() {
            widget.trip.expenses.insert(0, newExpense);
          });
        },
      ),
    );
  }

  void _openEditExpenseModal(Expense expense) {
    showDialog(
      context: context,
      builder: (ctx) => AddExpenseDialog(
        currency: widget.trip.currency,
        expenseToEdit: expense,
        onExpenseSaved: (updatedExpense) {
          setState(() {
            final index = widget.trip.expenses.indexWhere((e) => e.id == expense.id);
            if (index != -1) {
              widget.trip.expenses[index] = updatedExpense;
            }
          });
        },
      ),
    );
  }

  void _openEditBudgetModal() {
    final controller = TextEditingController(text: widget.trip.totalBudget.toStringAsFixed(0));
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Update Trip Budget', style: AppTextStyles.heading3),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter the total allocated financial budget for this journey.',
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 14),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: '${widget.trip.currency} ',
                labelText: 'Total Budget',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newBudget = double.tryParse(controller.text);
              if (newBudget != null && newBudget >= 0) {
                setState(() {
                  widget.trip.totalBudget = newBudget;
                });
                Navigator.of(ctx).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final expenses = widget.trip.expenses;
    final filteredExpenses = _filterCategory == null
        ? expenses
        : expenses.where((e) => e.category == _filterCategory).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Budget Summary Card
          BudgetSummaryCard(
            totalBudget: widget.trip.totalBudget,
            totalSpent: widget.trip.totalSpent,
            remaining: widget.trip.remainingBudget,
            currency: widget.trip.currency,
            onEditBudget: _openEditBudgetModal,
          ),
          const SizedBox(height: 16),

          // Header + Add Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Planned Expenses', style: AppTextStyles.heading2),
              ElevatedButton.icon(
                onPressed: _openAddExpenseModal,
                icon: const Icon(Icons.add_rounded, size: 16),
                label: const Text('Add Expense'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Category Filter Chips (SingleChildScrollView horizontal)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  label: 'All (${expenses.length})',
                  isSelected: _filterCategory == null,
                  onTap: () => setState(() => _filterCategory = null),
                ),
                ...ExpenseCategory.values.map((cat) {
                  final count = expenses.where((e) => e.category == cat).length;
                  final temp = Expense(id: '', title: '', amount: 0, category: cat, date: '');
                  return _buildFilterChip(
                    label: '${temp.categoryName} ($count)',
                    isSelected: _filterCategory == cat,
                    onTap: () => setState(() => _filterCategory = cat),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Expense List (Card widgets with working remove action)
          if (filteredExpenses.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Column(
                children: [
                  const Icon(Icons.wallet_outlined, size: 36, color: AppColors.textMuted),
                  const SizedBox(height: 8),
                  const Text('No expenses recorded in this category', style: AppTextStyles.bodyBold),
                  const SizedBox(height: 4),
                  Text(
                    'Tap "+ Add Expense" to record a financial transaction.',
                    style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredExpenses.length,
              itemBuilder: (context, index) {
                final expense = filteredExpenses[index];
                return ExpenseCard(
                  expense: expense,
                  currency: widget.trip.currency,
                  onEdit: () => _openEditExpenseModal(expense),
                  onRemove: () {
                    setState(() {
                      widget.trip.expenses.removeWhere((e) => e.id == expense.id);
                    });
                  },
                );
              },
            ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.primary,
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : AppColors.textSecondary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? AppColors.primary : AppColors.cardBorder,
          ),
        ),
        showCheckmark: false,
      ),
    );
  }
}

