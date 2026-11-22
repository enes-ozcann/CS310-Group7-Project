// stores the information for one place
class Place {
  const Place({
    required this.id,
    required this.name,
    required this.city,
    required this.category,
    required this.description,
  });

  final String id;
  final String name;
  final String city;
  final String category;
  final String description;
}