class SearchOption {
  final String name;
  final String type;
  final int id;
  final String? imageUrl;

  SearchOption({
    required this.name,
    required this.type,
    required this.id,
    this.imageUrl,
  });
}
