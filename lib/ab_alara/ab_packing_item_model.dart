class PackingPreviewItem {
  PackingPreviewItem(this.name, this.category,
      {this.quantity = 1, this.packed = false, this.suggestion = ''});
  final String name;
  final String category;
  final String suggestion;
  int quantity;
  bool packed;
}
