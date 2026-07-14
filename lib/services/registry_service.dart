import 'api_service.dart';
import '../models/certificate.dart';

class RegistryService {

  RegistryService(this._apiService);
  final ApiService _apiService;

  Future<List<Certificate>> getMyCertificates() async {
    try {
      final response = await _apiService.get('/registry/certificates');
      final List<dynamic> certificatesList = response['data'];
      return certificatesList.map((json) => Certificate.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load certificates: $e');
    }
  }

  Future<Certificate> getCertificateById(String id) async {
    try {
      final response = await _apiService.get('/registry/certificates/$id');
      return Certificate.fromJson(response['data']);
    } catch (e) {
      throw Exception('Failed to load certificate: $e');
    }
  }

  Future<Map<String, dynamic>> requestCertificate(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiService.post(
        '/registry/certificates',
        data: data,
      );
      return {
        'success': true,
        'certificate': Certificate.fromJson(response['data']),
        'message': response['message'],
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> bookAppointment(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.post(
        '/registry/appointments',
        data: data,
      );
      return {
        'success': true,
        'message': response['message'],
        'appointmentId': response['appointmentId'],
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}