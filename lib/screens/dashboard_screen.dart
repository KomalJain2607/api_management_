import 'package:flutter/material.dart';
import '../screens/sidebar.dart';
import '../widgets/api_endpoints_list.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF282B3A),
        title: const Text('Dashboard'),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
      drawer: const Sidebar(),
      body: Container(
        color: const Color(0xFFF7F8F3), // Off-white background
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'API Discovery Summary',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF002C3E), // Dark blue text
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _buildSensitivityItem('15', 'Highly Sensitive',
                          const Color(0xFFF7444E)), // Red for Highly Sensitive
                      SizedBox(width: 10),
                      _buildSensitivityItem(
                          '62',
                          'Sensitive',
                          const Color.fromARGB(
                              255, 251, 212, 37)), // Cyan for Sensitive
                      SizedBox(width: 10),
                      _buildSensitivityItem('19', 'Non Sensitive',
                          Colors.green), // Keep green for Non Sensitive
                    ],
                  ),
                ],
              ),
            ),
            const ApiEndpointsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSensitivityItem(String count, String label, Color color) {
    return Container(
      width: 240.0,
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            alignment: Alignment.center,
            child: Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Color(0xFF002C3E), // Dark blue text
            ),
          ),
        ],
      ),
    );
  }
}
