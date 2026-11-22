import 'ss_expense_model.dart';
import '../ab_alara/ab_packing_item_model.dart';
import '../eo_enes/eo_place_model.dart';

class TripDayItinerary {
  final String dayNumber; // '01', '02', '03'
  final String month; // 'JUN'
  final String title;
  final String description;

  const TripDayItinerary({
    required this.dayNumber,
    required this.month,
    required this.title,
    required this.description,
  });
}

/// Unified Trip Model connecting all member features:
/// - Baler (bc_): Trip listing, dates, destination, archive status
/// - Enes (eo_): Current temp, weather condition, weather tips, overview
/// - Alara (ab_): Packing checklist items
/// - Şeyma (ss_): Budget tracking, total budget, expense list
class Trip {
  final String id;
  final String title;
  final String destination;
  final String country;
  final String startDate;
  final String endDate;
  final int daysToGo;
  final String imageUrl;
  double totalBudget;
  final String currency;
  final List<Expense> expenses;
  final List<PackingPreviewItem> packingList;
  final List<Place> savedPlaces;
  final List<TripDayItinerary> itinerary;
  final int currentTemp;
  final String weatherCondition;
  final List<String> weatherTips;
  bool isArchived;

  Trip({
    required this.id,
    required this.title,
    required this.destination,
    required this.country,
    required this.startDate,
    required this.endDate,
    required this.daysToGo,
    required this.imageUrl,
    required this.totalBudget,
    this.currency = '€',
    required this.expenses,
    required this.packingList,
    required this.savedPlaces,
    required this.itinerary,
    required this.currentTemp,
    required this.weatherCondition,
    required this.weatherTips,
    this.isArchived = false,
  });

  double get totalSpent => expenses.fold(0.0, (sum, item) => sum + item.amount);
  double get remainingBudget => totalBudget - totalSpent;
  double get utilizationPercentage => totalBudget > 0 ? (totalSpent / totalBudget).clamp(0.0, 1.0) : 0.0;
  int get packedCount => packingList.where((p) => p.packed).length;
}
