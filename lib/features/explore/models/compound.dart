class Compound {
  final int id;
  final int areaId;
  final String name;
  final String imagePath;

  Compound({
    required this.id,
    required this.areaId,
    required this.name,
    required this.imagePath,
  });

  factory Compound.fromJson(Map<String, dynamic> json) {
    return Compound(
      id: json['id'] ?? 0,
      areaId: json['area_id'] ?? 0,
      name: json['name'] ?? '',
      imagePath: json['image_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'area_id': areaId, 'name': name, 'image_path': imagePath};
  }
}
