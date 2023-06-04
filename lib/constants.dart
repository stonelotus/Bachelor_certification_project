import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class NavigationRouteIDs {
  NavigationRouteIDs._();

  static const List<String> routeIDs = [
    'EventSearchResults', // index 0
    'EventSearchResults', // index 1
    'MyTickets', // index 2
  ];
}

class BottomNavBarNavigationItems {
  BottomNavBarNavigationItems._();

  static const List<TabItem> navigationItems = [
    TabItem(icon: Icons.home, title: 'Home'),
    TabItem(icon: Icons.map, title: 'Discovery'),
    TabItem(icon: Icons.self_improvement, title: 'My Tickets'),
  ];
}
