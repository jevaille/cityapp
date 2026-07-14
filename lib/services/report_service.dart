import 'api_service.dart';
import '../models/report.dart';

class ReportService {

  ReportService(this._apiService);
  final ApiService _apiService;

  Future<List<Report>> getReports() async {
    try {
      final response = await _apiService.get('/reports');
      final List<dynamic> reportsList = response['data'];
      return reportsList.map((json) => Report.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load reports: $e');
    }
  }

  Future<Report> getReportById(String id) async {
    try {
      final response = await _apiService.get('/reports/$id');
      return Report.fromJson(response['data']);
    } catch (e) {
      throw Exception('Failed to load report: $e');
    }
  }

  Future<Map<String, dynamic>> submitReport(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.post(
        '/reports',
        data: data,
      );
      return {
        'success': true,
        'report': Report.fromJson(response['data']),
        'message': response['message'],
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> updateReportStatus(
    String id,
    String status,
  ) async {
    try {
      final response = await _apiService.put(
        '/reports/$id/status',
        data: {'status': status},
      );
      return {
        'success': true,
        'message': response['message'],
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<List<Report>> getMyReports() async {
    try {
      final response = await _apiService.get('/reports/my');
      final List<dynamic> reportsList = response['data'];
      return reportsList.map((json) => Report.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load my reports: $e');
    }
  }
}