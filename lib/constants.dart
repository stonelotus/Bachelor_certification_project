import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class NavigationRouteIDs {
  NavigationRouteIDs._();

  static const List<String> routeIDs = [
    'HomePage', // index 0
    'EventSearchResults', // index 1
    'MyTickets', // index 2
    'MyProfile'
  ];
}

class BottomNavBarNavigationItems {
  BottomNavBarNavigationItems._();

  static const List<TabItem> navigationItems = [
    TabItem(icon: Icons.home, title: 'Home'),
    TabItem(icon: Icons.map, title: 'Discovery'),
    TabItem(icon: Icons.self_improvement, title: 'My Tickets'),
    TabItem(icon: Icons.person, title: 'My Profile'),
  ];
}

class MockCredentials {
  MockCredentials._();

  static const String buyerPK =
      '0x81dd0d1c1e65628c83e8ea3637bbea5b2d0e987246bb02e2b02d7d4ffec20ffc';
  static const String eventOrganizerPK =
      '0x03f6f8a57ccdacf8dd8ea005e3cff045989d4123d952d45df4e637789e0edda5';
}
