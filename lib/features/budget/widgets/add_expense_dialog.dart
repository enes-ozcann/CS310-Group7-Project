import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/validator_utils.dart';
import '../../../models/expense_model.dart';

class AddExpenseDialog extends StatefulWidget {
  final String currency;
  final Expense? expenseToEdit;
  final Function(Expense) onExpenseSaved;

  const AddExpenseDialog({
    super.key,
    this.currency = '€',
    this.expenseToEdit,
    required this.onExpenseSaved,
  });

  @override
  State<AddExpenseDialog> createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _dateController;
  late TextEditingController _notesController;
  late ExpenseCategory _selectedCategory;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    final edit = widget.expenseToEdit;
    _titleController = TextEditingController(text: edit?.title ?? '');
    _amountController = TextEditingController(text: edit != null ? edit.amount.toStringAsFixed(0) : '');
    _dateController = TextEditingController(text: edit?.date ?? formatToReadableDate(DateTime.now()));
    _notesController = TextEditingController(text: edit?.notes ?? '');
    _selectedCategory = edit?.category ?? ExpenseCategory.food;
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.primaryTeal),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = formatToReadableDate(picked);
      });
    }
  }

  void _handleSavePressed() {
    // 1. Inline Form Validation (Rubric Requirement 6)
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final amount = double.parse(_amountController.text.trim());
      final isEditing = widget.expenseToEdit != null;

      // 2. Confirmation Dialog (Matches Figma Wireframe #8)
      showDialog(
        context: context,
        builder: (confirmCtx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(isEditing ? 'Update Expense?' : 'Save Expense?', style: AppTextStyles.heading3),
          content: Text(
            'Are you sure you want to ${isEditing ? "update" : "add"} "$title" (${widget.currency}$amount) to your budget?',
            style: AppTextStyles.body,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(confirmCtx).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final savedExpense = Expense(
                  id: widget.expenseToEdit?.id ?? 'exp-${DateTime.now().millisecondsSinceEpoch}',
                  title: title,
                  amount: amount,
                  category: _selectedCategory,
                  date: _dateController.text.trim(),
                  notes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
                );

                Navigator.of(confirmCtx).pop(); // Close confirm dialog
                Navigator.of(context).pop();    // Close form dialog
                widget.onExpenseSaved(savedExpense);

                showCustomSnackBar(
                  context,
                  isEditing ? 'Expense updated successfully!' : 'Expense added to trip budget!',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryTeal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirm'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.expenseToEdit != null;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEditing ? 'Edit Expense' : 'New Expense',
                      style: AppTextStyles.heading2,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20, color: AppColors.textMuted),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                Text(
                  'Record or update an itinerary expense.',
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 16),

                // Field 1: Title (with Inline Validation)
                const Text('Title (e.g. Dinner, Bus Ticket) *', style: AppTextStyles.caption),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _titleController,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'e.g. Dinner at Marina, Ferry Ticket',
                    prefixIcon: Icon(Icons.edit_note_rounded, size: 20),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter an expense title';
                    }
                    if (val.trim().length < 2) {
                      return 'Title must be at least 2 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // Field 2: Amount (with Inline Validation)
                Text('Amount (${widget.currency}) *', style: AppTextStyles.caption),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        widget.currency,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  validator: ValidatorUtils.validateAmount,
                ),
                const SizedBox(height: 14),

                // Field 3: Category Dropdown
                const Text('Category', style: AppTextStyles.caption),
                const SizedBox(height: 4),
                DropdownButtonFormField<ExpenseCategory>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.category_outlined, size: 20),
                  ),
                  items: ExpenseCategory.values.map((cat) {
                    final temp = Expense(id: '', title: '', amount: 0, category: cat, date: '');
                    return DropdownMenuItem(
                      value: cat,
                      child: Row(
                        children: [
                          Icon(temp.categoryIcon, size: 18, color: temp.categoryColor),
                          const SizedBox(width: 8),
                          Text(temp.categoryName, style: AppTextStyles.body),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedCategory = val);
                  },
                ),
                const SizedBox(height: 14),

                // Field 4: Date
                const Text('Date', style: AppTextStyles.caption),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  onTap: _pickDate,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today_outlined, size: 18),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                ),
                const SizedBox(height: 14),

                // Field 5: Optional Notes
                const Text('Notes (Optional)', style: AppTextStyles.caption),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    hintText: 'e.g. Includes tip or shared payment',
                    prefixIcon: Icon(Icons.notes_rounded, size: 20),
                  ),
                ),
                const SizedBox(height: 20),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _handleSavePressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryTeal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 1,
                        ),
                        child: Text(
                          isEditing ? 'Update Expense' : 'Save Expense',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
