import 'package:flutter/material.dart';

class MarriageCertificateScreen extends StatefulWidget {
  const MarriageCertificateScreen({super.key});

  @override
  State<MarriageCertificateScreen> createState() =>
      _MarriageCertificateScreenState();
}

class _MarriageCertificateScreenState
    extends State<MarriageCertificateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _husbandNameController = TextEditingController();
  final _wifeNameController = TextEditingController();
  final _placeOfMarriageController = TextEditingController();
  DateTime? _dateOfMarriage;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marriage Certificate'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: _husbandNameController,
                label: "Husband's Name",
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter husband's name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _wifeNameController,
                label: "Wife's Name",
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter wife's name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildDatePicker(),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _placeOfMarriageController,
                label: 'Place of Marriage',
                icon: Icons.location_on,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter place of marriage';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _requestCertificate,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Request Certificate'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          setState(() {
            _dateOfMarriage = picked;
          });
        }
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Date of Marriage',
          prefixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(),
        ),
        child: Text(
          _dateOfMarriage != null
              ? '${_dateOfMarriage!.day}/${_dateOfMarriage!.month}/${_dateOfMarriage!.year}'
              : 'Select date of marriage',
          style: TextStyle(
            color: _dateOfMarriage != null ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }

  void _requestCertificate() {
    if (_formKey.currentState!.validate() && _dateOfMarriage != null) {
      setState(() => _isLoading = true);
      // TODO: Request certificate
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Certificate requested successfully!'),
            ),
          );
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  void dispose() {
    _husbandNameController.dispose();
    _wifeNameController.dispose();
    _placeOfMarriageController.dispose();
    super.dispose();
  }
}