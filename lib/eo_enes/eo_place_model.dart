/// Unified Place Model (Base: Enes Özcan [eo_], Extended for Nehir & Alara)
/// Contains all common properties, plus specific extensions needed across screens.
class Place {
  final String id;
  final String name;
  final String city;
  final String category;
  final String description;

  // Extended properties for Nehir's image handling (asset vs network)
  final String image;
  final bool isLocal;

  // Extended property for Alara's visited checklist
  final bool visited;

  const Place({
    required this.id,
    required this.name,
    required this.city,
    required this.category,
    required this.description,
    this.image = 'assets/images/rome.png',
    this.isLocal = true,
    this.visited = false,
  });

  Place copyWith({
    String? id,
    String? name,
    String? city,
    String? category,
    String? description,
    String? image,
    bool? isLocal,
    bool? visited,
  }) {
    return Place(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      category: category ?? this.category,
      description: description ?? this.description,
      image: image ?? this.image,
      isLocal: isLocal ?? this.isLocal,
      visited: visited ?? this.visited,
    );
  }
}
