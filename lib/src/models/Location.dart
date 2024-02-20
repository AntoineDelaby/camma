class Location {
  final int id;
  final String label;
  final double surface;
  final int available;
  final String commentaires;

  const Location(
      {required this.id,
      required this.label,
      required this.surface,
      required this.available,
      required this.commentaires});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        id: json['id'],
        label: json['label'],
        surface: json['surface'],
        available: json['available'],
        commentaires: json['commentaires']);
  }
}
