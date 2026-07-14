import 'package:flutter/material.dart';

class DeathCertificateScreen extends StatefulWidget {
  const DeathCertificateScreen({super.key});

  @override
  State<DeathCertificateScreen> createState() => _DeathCertificateScreenState();
}

class _DeathCertificateScreenState extends State<DeathCertificateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _deceasedNameController = TextEditingController();
  final _placeOfDeathController = TextEditingController();
  final _causeOfDeathController = TextEditingController();
  final _informantNameController = TextEditingController();
  DateTime? _dateOfDeath;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Death Certificate'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: _deceasedNameController,
                label: 'Deceased Name',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter deceased name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildDatePicker(),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _placeOfDeathController,
                label: 'Place of Death',
                icon: Icons.location_on,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter place of death';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _causeOfDeathController,
                label: 'Cause of Death',
                icon: Icons.medical_services,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter cause of death';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _informantNameController,
                label: "Informant's Name",
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter informant's name";
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
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      maxLines: maxLines,
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
            _dateOfDeath = picked;
          });
        }
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Date of Death',
          prefixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(),
        ),
        child: Text(
          _dateOfDeath != null
              ? '${_dateOfDeath!.day}/${_dateOfDeath!.month}/${_dateOfDeath!.year}'
              : 'Select date of death',
          style: TextStyle(
            color: _dateOfDeath != null ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }

  void _requestCertificate() {
    if (_formKey.currentState!.validate() && _dateOfDeath != null) {
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
    _deceasedNameController.dispose();
    _placeOfDeathController.dispose();
    _causeOfDeathController.dispose();
    _informantNameController.dispose();
    super.dispose();
  }
}