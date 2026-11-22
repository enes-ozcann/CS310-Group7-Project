class PlacePreview {
  const PlacePreview(this.name, this.category, this.image,
      {this.visited = false});
  final String name;
  final String category;
  final String image;
  final bool visited;
}
