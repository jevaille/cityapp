import 'package:flutter/material.dart';
import '../models/report.dart';
import '../services/report_service.dart';

class ReportProvider extends ChangeNotifier {

  ReportProvider(this._reportService);
  final ReportService _reportService;
  List<Report> _reports = [];
  bool _isLoading = false;

  List<Report> get reports => _reports;
  bool get isLoading => _isLoading;

  Future<void> loadReports() async {
    _isLoading = true;
    notifyListeners();

    try {
      _reports = await _reportService.getReports();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to load reports: $e');
    }
  }

  Future<void> loadMyReports() async {
    _isLoading = true;
    notifyListeners();

    try {
      _reports = await _reportService.getMyReports();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to load my reports: $e');
    }
  }

  Future<bool> submitReport(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _reportService.submitReport(data);
      _isLoading = false;
      notifyListeners();
      return result['success'];
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> updateReportStatus(String id, String status) async {
    try {
      await _reportService.updateReportStatus(id, status);
      await loadReports();
    } catch (e) {
      throw Exception('Failed to update report status: $e');
    }
  }
}