import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

enum ExpenseCategory {
  transport,
  accommodation,
  food,
  activities,
  other,
}

class Expense {
  final String id;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final String date;
  final String? notes;

  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.notes,
  });

  String get categoryName {
    switch (category) {
      case ExpenseCategory.transport:
        return 'Transport';
      case ExpenseCategory.accommodation:
        return 'Stay';
      case ExpenseCategory.food:
        return 'Food & Dining';
      case ExpenseCategory.activities:
        return 'Activities';
      case ExpenseCategory.other:
        return 'Other';
    }
  }

  IconData get categoryIcon {
    switch (category) {
      case ExpenseCategory.transport:
        return Icons.directions_transit_rounded;
      case ExpenseCategory.accommodation:
        return Icons.hotel_rounded;
      case ExpenseCategory.food:
        return Icons.restaurant_rounded;
      case ExpenseCategory.activities:
        return Icons.confirmation_number_rounded;
      case ExpenseCategory.other:
        return Icons.more_horiz_rounded;
    }
  }

  Color get categoryColor {
    switch (category) {
      case ExpenseCategory.transport:
        return AppColors.transport;
      case ExpenseCategory.accommodation:
        return AppColors.stay;
      case ExpenseCategory.food:
        return AppColors.food;
      case ExpenseCategory.activities:
        return AppColors.activities;
      case ExpenseCategory.other:
        return AppColors.textSecondary;
    }
  }
}
