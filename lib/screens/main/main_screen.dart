import 'package:flutter/material.dart';
import '../../app/theme.dart';
import 'widgets/app_header.dart';
import 'widgets/sidebar_drawer.dart';
import 'pages/dashboard_page.dart';
import 'pages/news_page.dart';
import 'pages/events_page.dart';
import 'pages/jobs_page.dart';
import 'pages/permits_page.dart';
import 'pages/reports_page.dart';
import 'pages/emergency_page.dart';
import 'pages/maps_page.dart';
import 'pages/directory_page.dart';
import 'pages/government_services_page.dart';
import 'pages/information_page.dart';  // ✅ ADD THIS IMPORT
import 'pages/cctv_page.dart';
import 'pages/settings_page.dart';
import 'pages/profile_page.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),        // 0
    const NewsPage(),              // 1
    const EventsPage(),            // 2
    const JobsPage(),              // 3
    const PermitsPage(),           // 4
    const ReportsPage(),           // 5
    EmergencyPage(),               // 6
    const MapsPage(),              // 7
    DirectoryPage(),               // 8
    const GovernmentServicesPage(),      // 9
    const InformationPage(),             // 10 ← ADDED
    const CctvPage(),                 //11
    const SettingsPage(),          // 12
    const ProfilePage(),           // 13
    
  ];

  final List<String> _pageTitles = [
    'Dashboard',                   // 0
    'News',                        // 1
    'Events',                      // 2
    'Jobs',                        // 3
    'Permits',                     // 4
    'Citizen Reports',             // 5
    'Emergency',                   // 6
    'Maps',                        // 7
    'Directory',                   // 8
    'Government Services',         // 9
    'Information',                 // 10 ← ADDED
    'CCTV',                         // 11
    'Settings',                    // 12
    'Profile',                     // 13
    
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppTheme.background,
      drawerScrimColor: Colors.transparent,
      drawer: SidebarDrawer(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _scaffoldKey.currentState?.closeDrawer();
        },
      ),
      body: Column(
        children: [
          AppHeader(
            pageTitle: _pageTitles[_selectedIndex],
            onMenuTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            onNotificationTap: () {
              // Navigate to notifications
            },
          ),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}