import 'package:flutter/material.dart';
import 'core/theme/app_pallete.dart';
import 'feature/auth/presentation/pages/login_page.dart';
import 'feature/auth/presentation/pages/signup_page.dart';
import 'feature/dashboard/presentation/pages/dashboard_page.dart';
import 'feature/settings/presentation/pages/settings_page.dart';
import 'feature/alerts/presentation/pages/alerts_page.dart';
import 'feature/map/presentation/pages/map_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/dashboard':
            return MaterialPageRoute(builder: (_) => const DashboardPage());
          case '/map':
            return MaterialPageRoute(builder: (_) => const MapPage());
          case '/alerts':
            return MaterialPageRoute(builder: (_) => const AlertsPage());
          case '/settings':
            return MaterialPageRoute(builder: (_) => const SettingsPage());
          default:
            return MaterialPageRoute(builder: (_) => const DashboardPage());
        }
      },
      title: 'Driver Behavior Tracker',
      theme: AppTheme.lightTheme,
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/map': (context) => const MapPage(),
        '/alerts': (context) => const AlertsPage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}

// Add navigation service
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = 
      GlobalKey<NavigatorState>();
}