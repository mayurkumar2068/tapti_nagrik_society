import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../home/home.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  MenuItem({required this.title, required this.icon, required this.onTap});
}

class MenuService {
  static List<MenuItem> getMenuItems(BuildContext context) {
    return [
      MenuItem(
        title: "DDS",
        icon: Icons.account_tree,
        onTap: () {
          homeViewKey.currentState?.toggleDrawer(); // Close drawer and handle navigation
        },
      ),
      MenuItem(
        title: "RD",
        icon: Icons.real_estate_agent_rounded,
        onTap: () {
          homeViewKey.currentState?.toggleDrawer(); // Add navigation to Profile screen
        },
      ),
      MenuItem(
        title: "FD",
        icon: Icons.account_balance,
        onTap: () {
          homeViewKey.currentState?.toggleDrawer(); // Add navigation to Add Account screen
        },
      ),
      MenuItem(
        title: "MIS",
        icon: Icons.update,
        onTap: () {
          homeViewKey.currentState?.toggleDrawer(); // Add navigation to Account Update screen
        },
      ),
    ];
  }
}
