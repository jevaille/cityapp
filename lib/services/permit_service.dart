import 'api_service.dart';
import '../models/permit.dart';

class PermitService {

  PermitService(this._apiService);
  final ApiService _apiService;

  Future<List<Permit>> getPermits() async {
    try {
      final response = await _apiService.get('/permits');
      final List<dynamic> permitsList = response['data'];
      return permitsList.map((json) => Permit.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load permits: $e');
    }
  }

  Future<Permit> getPermitById(String id) async {
    try {
      final response = await _apiService.get('/permits/$id');
      return Permit.fromJson(response['data']);
    } catch (e) {
      throw Exception('Failed to load permit: $e');
    }
  }

  Future<Map<String, dynamic>> applyForPermit(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.post(
        '/permits',
        data: data,
      );
      return {
        'success': true,
        'permit': Permit.fromJson(response['data']),
        'message': response['message'],
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> renewPermit(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiService.put(
        '/permits/$id/renew',
        data: data,
      );
      return {
        'success': true,
        'permit': Permit.fromJson(response['data']),
        'message': response['message'],
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<List<Permit>> getMyPermits() async {
    try {
      final response = await _apiService.get('/permits/my');
      final List<dynamic> permitsList = response['data'];
      return permitsList.map((json) => Permit.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load my permits: $e');
    }
  }
}