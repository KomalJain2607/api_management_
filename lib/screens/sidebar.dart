import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: const Color(0xFF282B3A),
      child: Column(
        children: [
          // Logo at the top
          Container(
            child: const ListTile(
              leading: Icon(Icons.logo_dev, color: Colors.white),
            ), // Replace with your logo
          ),
          const Divider(color: Colors.white),
          // Menu items
          ListTile(
            leading: const Icon(Icons.dashboard, color: Colors.white),
            title:
                const Text('Dashboard', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to Dashboard
            },
          ),
          ListTile(
            leading: const Icon(Icons.api, color: Colors.white),
            title: const Text('API Inventory',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to API Inventory
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text('Profile', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to Profile
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title:
                const Text('Settings', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to Settings
            },
          ),
        ],
      ),
    );
  }
}
