class FilterOptions {
  final int minBedrooms;
  final int maxBedrooms;
  final List<int> minPriceList;
  final List<int> maxPriceList;

  FilterOptions({
    required this.minBedrooms,
    required this.maxBedrooms,
    required this.minPriceList,
    required this.maxPriceList,
  });

  factory FilterOptions.fromJson(Map<String, dynamic> json) {
    return FilterOptions(
      minBedrooms: json['min_bedrooms'],
      maxBedrooms: json['max_bedrooms'],
      minPriceList: List<int>.from(json['min_price_list'] ?? []),
      maxPriceList: List<int>.from(json['max_price_list'] ?? []),
    );
  }
}
