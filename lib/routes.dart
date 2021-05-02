import 'package:flutter/material.dart';

import 'screens/about_page.dart';
import 'screens/donation_page.dart';
import 'screens/info_page.dart';
import 'screens/location_page.dart';

class RouteGenerator {
  static const String home = '/';
  static const String info = '/info';
  static const String about = '/about';
  static const String donation = '/donation';

  RouteGenerator();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const LocationPage());
      case info:
        return MaterialPageRoute(builder: (_) => const InfoPage());
      case about:
        return MaterialPageRoute(builder: (_) => const AboutPage());
      case donation:
        return MaterialPageRoute(builder: (_) => const DonationPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('Route not found'),
        ),
      );
    });
  }
}
