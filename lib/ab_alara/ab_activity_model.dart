class ActivityPreview {
  const ActivityPreview(
      this.name, this.type, this.time, this.location, this.tip,
      {this.done = false});
  final String name;
  final String type;
  final String time;
  final String location;
  final String tip;
  final bool done;
}
