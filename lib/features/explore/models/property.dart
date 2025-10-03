class Property {
  final int id;
  final String image;
  final String propertyTypeName;
  final String minReadyBy;
  final String currency;
  final int maxPrice;
  final int minInstallments;
  final int maxInstallmentYears;
  final int numberOfBedrooms;
  final String compoundName;
  final int compoundId;
  final String areaName;
  final int areaId;
  final int numberOfBathrooms;
  final int maxUnitArea;
  bool isFavorite;

  Property({
    required this.id,
    required this.image,
    required this.propertyTypeName,
    required this.minReadyBy,
    required this.currency,
    required this.maxPrice,
    required this.minInstallments,
    required this.maxInstallmentYears,
    required this.numberOfBedrooms,
    required this.compoundName,
    required this.compoundId,
    required this.areaName,
    required this.areaId,
    required this.numberOfBathrooms,
    required this.maxUnitArea,
    this.isFavorite = false,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      propertyTypeName: json['property_type']?['name'] ?? '',
      minReadyBy: json['min_ready_by'] ?? '',
      currency: json['currency'] ?? '',
      maxPrice: json['max_price'] ?? 0,
      minInstallments: json['min_installments'] ?? 0,
      maxInstallmentYears: json['max_installment_years'] ?? 0,
      numberOfBedrooms: json['number_of_bedrooms'] ?? 0,
      compoundName: json['compound']?['name'] ?? '',
      compoundId: json['compound']?['id'] ?? 0,
      areaName: json['area']?['name'] ?? '',
      areaId: json['area']?['id'] ?? 0,
      numberOfBathrooms: json['number_of_bathrooms'] ?? 0,
      maxUnitArea: json['max_unit_area'] ?? 0,
    );
  }
}
