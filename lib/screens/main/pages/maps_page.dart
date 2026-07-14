import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/theme.dart';
import '../../../widgets/common/page_background.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late CityLocation _selectedLocation = _locations.first;

  static const List<CityLocation> _locations = [
    CityLocation(
      name: 'General Santos City Hall',
      address: 'City Hall, General Santos City',
      latitude: 6.1115,
      longitude: 125.1711,
      mapOffset: Offset(-45, -52),
      category: 'Government',
      icon: Icons.account_balance,
    ),
    CityLocation(
      name: 'Gensan Plaza',
      address: 'Plaza, General Santos City',
      latitude: 6.1136,
      longitude: 125.1724,
      mapOffset: Offset(48, -60),
      category: 'Park',
      icon: Icons.park,
    ),
    CityLocation(
      name: 'SM City General Santos',
      address: 'SM City, General Santos City',
      latitude: 6.1136,
      longitude: 125.1682,
      mapOffset: Offset(-135, -12),
      category: 'Shopping',
      icon: Icons.shopping_bag,
    ),
    CityLocation(
      name: 'Gensan Hospital',
      address: 'Hospital, General Santos City',
      latitude: 6.1069,
      longitude: 125.1708,
      mapOffset: Offset(-18, 44),
      category: 'Healthcare',
      icon: Icons.local_hospital,
    ),
    CityLocation(
      name: 'University of Mindanao - Gensan',
      address: 'University, General Santos City',
      latitude: 6.1101,
      longitude: 125.1779,
      mapOffset: Offset(138, -24),
      category: 'Education',
      icon: Icons.school,
    ),
    CityLocation(
      name: 'General Santos Fish Port',
      address: 'Fish Port, General Santos City',
      latitude: 6.0970,
      longitude: 125.1709,
      mapOffset: Offset(40, 126),
      category: 'Landmark',
      icon: Icons.directions_boat,
    ),
    CityLocation(
      name: 'KCC Veranza Gensan',
      address: 'KCC Veranza, General Santos City',
      latitude: 6.1120,
      longitude: 125.1695,
      mapOffset: Offset(-122, -92),
      category: 'Shopping',
      icon: Icons.shopping_bag,
    ),
    CityLocation(
      name: 'Gensan Airport',
      address: 'General Santos International Airport',
      latitude: 6.0560,
      longitude: 125.0980,
      mapOffset: Offset(134, 96),
      category: 'Transportation',
      icon: Icons.flight,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildMap(),
          _buildSelectedLocation(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: _locations.length,
              itemBuilder: (context, index) {
                final location = _locations[index];
                return _buildLocationCard(location);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Maps',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Find important places in General Santos City',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textLight,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_locations.length} Places',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryBlue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return Container(
      height: 240,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final mapSize = Size(
            math.max(constraints.maxWidth * 1.35, 900),
            620,
          );

          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Positioned.fill(
                  child: InteractiveViewer(
                    minScale: 0.75,
                    maxScale: 2.8,
                    boundaryMargin: const EdgeInsets.all(180),
                    constrained: false,
                    child: SizedBox(
                      width: mapSize.width,
                      height: mapSize.height,
                      child: Stack(
                        children: [
                          CustomPaint(
                            size: mapSize,
                            painter: _DraggableMapPainter(),
                          ),
                          for (final location in _locations)
                            _MapMarker(
                              location: location,
                              position: _mapPoint(location, mapSize),
                              color: _categoryColor(location.category),
                              selected: location == _selectedLocation,
                              onTap: () {
                                setState(() {
                                  _selectedLocation = location;
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 12,
                  child: _MapHint(),
                ),
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: FloatingActionButton.small(
                    heroTag: 'open-selected-place-map',
                    backgroundColor: AppTheme.primaryBlue,
                    foregroundColor: Colors.white,
                    onPressed: () => _openInGoogleMaps(_selectedLocation),
                    child: const Icon(Icons.open_in_new_rounded),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Offset _mapPoint(CityLocation location, Size size) {
    final scale = math.min(size.width / 900, 1.35);
    final x = (size.width * 0.5) + (location.mapOffset.dx * scale);
    final y = 132 + (location.mapOffset.dy * scale);
    return Offset(x.clamp(48, size.width - 48), y.clamp(48, size.height - 48));
  }

  Widget _buildSelectedLocation() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppTheme.primaryBlue.withValues(alpha: 0.18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _categoryColor(_selectedLocation.category)
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                _selectedLocation.icon,
                color: _categoryColor(_selectedLocation.category),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedLocation.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _selectedLocation.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: () => _openDirections(_selectedLocation),
              icon: const Icon(Icons.navigation_rounded, size: 16),
              label: const Text('Navigate'),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard(CityLocation location) {
    final categoryColor = _categoryColor(location.category);
    final isSelected = location == _selectedLocation;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        setState(() {
          _selectedLocation = location;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryBlue
                : AppTheme.borderLight.withValues(alpha: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: categoryColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  location.icon,
                  size: 22,
                  color: categoryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      location.address,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textLight,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: categoryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        location.category,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: categoryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Navigate',
                onPressed: () => _openDirections(location),
                icon: const Icon(Icons.navigation_rounded),
                color: AppTheme.primaryBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _categoryColor(String category) {
    switch (category) {
      case 'Government':
        return Colors.blue;
      case 'Shopping':
        return Colors.red;
      case 'Healthcare':
      case 'Park':
        return Colors.green;
      case 'Education':
        return Colors.purple;
      case 'Landmark':
        return Colors.orange;
      case 'Transportation':
        return Colors.cyan;
      default:
        return AppTheme.textLight;
    }
  }

  Future<void> _openInGoogleMaps(CityLocation location) async {
    final uri = Uri.https('www.google.com', '/maps/search/', {
      'api': '1',
      'query': '${location.latitude},${location.longitude}',
    });
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _openDirections(CityLocation location) async {
    final uri = Uri.https('www.google.com', '/maps/dir/', {
      'api': '1',
      'destination': '${location.latitude},${location.longitude}',
      'travelmode': 'driving',
    });
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _MapHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.open_with_rounded,
              size: 16,
              color: AppTheme.primaryBlue,
            ),
            SizedBox(width: 6),
            Text(
              'Drag map',
              style: TextStyle(
                color: AppTheme.textDark,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapMarker extends StatelessWidget {
  const _MapMarker({
    required this.location,
    required this.position,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final CityLocation location;
  final Offset position;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx - 22,
      top: position.dy - 44,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedScale(
          scale: selected ? 1.16 : 1,
          duration: const Duration(milliseconds: 180),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: selected ? color : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  location.icon,
                  color: selected ? Colors.white : color,
                  size: 21,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: color,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DraggableMapPainter extends CustomPainter {
  static const Size _baseSize = Size(900, 620);

  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()..color = const Color(0xFFEAF5EE);
    canvas.drawRect(Offset.zero & size, background);

    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.55)
      ..strokeWidth = 1;
    for (var x = 0.0; x <= size.width; x += 72) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (var y = 0.0; y <= size.height; y += 72) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    canvas.save();
    canvas.scale(size.width / _baseSize.width, size.height / _baseSize.height);

    _drawRoad(
      canvas,
      [
        const Offset(40, 420),
        const Offset(190, 365),
        const Offset(355, 335),
        const Offset(520, 300),
        const Offset(715, 260),
        const Offset(880, 210),
      ],
      width: 28,
      color: const Color(0xFFFFF8D8),
    );
    _drawRoad(
      canvas,
      [
        const Offset(105, 70),
        const Offset(190, 170),
        const Offset(320, 265),
        const Offset(430, 385),
        const Offset(540, 555),
      ],
      width: 24,
      color: const Color(0xFFFFF8D8),
    );
    _drawRoad(
      canvas,
      [
        const Offset(650, 30),
        const Offset(610, 145),
        const Offset(570, 260),
        const Offset(520, 382),
        const Offset(470, 590),
      ],
      width: 22,
      color: const Color(0xFFFFFFFF),
    );
    _drawRoad(
      canvas,
      [
        const Offset(35, 165),
        const Offset(180, 205),
        const Offset(360, 218),
        const Offset(540, 205),
        const Offset(845, 120),
      ],
      width: 18,
      color: const Color(0xFFFFFFFF),
    );

    final waterPaint = Paint()..color = const Color(0xFFBFE6F7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          _baseSize.width - 170,
          _baseSize.height - 210,
          220,
          260,
        ),
        const Radius.circular(80),
      ),
      waterPaint,
    );

    final parkPaint = Paint()..color = const Color(0xFFCDEBCB);
    canvas.drawCircle(const Offset(285, 150), 72, parkPaint);
    canvas.drawCircle(const Offset(690, 430), 86, parkPaint);

    canvas.restore();
  }

  void _drawRoad(
    Canvas canvas,
    List<Offset> points, {
    required double width,
    required Color color,
  }) {
    final border = Paint()
      ..color = const Color(0xFFD8D2BF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = width + 5;
    final road = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = width;

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    canvas
      ..drawPath(path, border)
      ..drawPath(path, road);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CityLocation {
  const CityLocation({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.mapOffset,
    required this.category,
    required this.icon,
  });

  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final Offset mapOffset;
  final String category;
  final IconData icon;
}
