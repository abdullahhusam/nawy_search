import 'package:nawy_search/features/explore/models/property.dart';

class PropertySearchResponse {
  final int totalProperties;
  final List<PropertyTypeCount> propertyTypes;
  final List<Property> values;

  PropertySearchResponse({
    required this.totalProperties,
    required this.propertyTypes,
    required this.values,
  });

  factory PropertySearchResponse.fromJson(Map<String, dynamic> json) {
    return PropertySearchResponse(
      totalProperties: json['total_properties'],
      propertyTypes: (json['property_types'] as List)
          .map((e) => PropertyTypeCount.fromJson(e))
          .toList(),
      values: (json['values'] as List)
          .map((e) => Property.fromJson(e))
          .toList(),
    );
  }
}

class PropertyTypeCount {
  final int id;
  final int count;

  PropertyTypeCount({required this.id, required this.count});

  factory PropertyTypeCount.fromJson(Map<String, dynamic> json) {
    return PropertyTypeCount(id: json['id'], count: json['count']);
  }
}
