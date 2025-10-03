import '../../features/explore/models/area.dart';
import '../../features/explore/models/compound.dart';
import '../../features/explore/models/filter_options.dart';
import '../../features/explore/models/property_search_response.dart';
import 'api_service.dart';

class AppApis {
  static final _api = ApiService();

  static Future<List<Area>> fetchAreas() async {
    print("Fetching Areas");
    final response = await _api.get('/areas.json');
    print("Fetched Areas");

    return (response.data as List).map((e) => Area.fromJson(e)).toList();
  }

  static Future<List<Compound>> fetchCompounds() async {
    print("Fetching Compounds");

    final response = await _api.get('/compounds.json');
    print("Fetched Compounds");

    return (response.data as List).map((e) => Compound.fromJson(e)).toList();
  }

  static Future<FilterOptions> fetchFilterOptions() async {
    print("Fetching Filter options");

    final response = await _api.get('/properties-get-filter-options.json');
    print("Fetched Filter options");

    return FilterOptions.fromJson(response.data);
  }

  static Future<PropertySearchResponse> fetchProperties(
    Map<String, dynamic> filters,
  ) async {
    final response = await _api.get(
      '/properties-search.json',
      queryParameters: filters,
    );
    return PropertySearchResponse.fromJson(response.data);
  }
}
