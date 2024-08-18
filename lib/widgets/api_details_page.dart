import 'package:flutter/material.dart';

class ApiDetailsPage extends StatelessWidget {
  final Map<String, dynamic> api;

  const ApiDetailsPage({Key? key, required this.api}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add Scaffold
      appBar: AppBar(
        title: const Text('Endpoint details'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1.0, // Add a slight shadow (adjust as needed)
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(), // Close button
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Make content scrollable
        child: Card(
          margin: const EdgeInsets.all(16.0), // Add margin
          elevation: 4.0,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity, // Full width
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. API Endpoint with GET badge
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: const Text(
                        'GET',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      api['endpoint'], // Dynamic endpoint
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16.0),

                // 2. API Details Section
                _buildDetailRow('API host:', 'api.wallarm.com'),
                _buildDetailRow('Application:', 'API Wallarm'),
                _buildDetailRow('Changed:', '7 Jun 2023, 3:05'),
                _buildDetailRow('Number of requests for 7 days:', '21K'),
                _buildDetailRow('Number of requests for 24 hours:', '6.5K'),
                _buildDetailRow('Avg. requests / s for 24 hours:', '15'),

                const SizedBox(height: 24.0),

                // 3. Risk Score Section
                const Text(
                  'Risk score',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                _buildRiskItem(
                    Icons.warning_amber_rounded,
                    Colors.orange,
                    'Vulnerable to BOLA',
                    'Variable path parts make the endpoint a potential target of BOLA (IDOR) attacks.'),
                _buildRiskItem(
                    Icons.error,
                    Colors.red,
                    '1 parameter with sensitive data',
                    'Parameters with sensitive data are always at risk of exposure.'),

                const SizedBox(height: 24.0),

                // 4. Request/Response Tabs Section
                // ... [Implement tabs for Request and Response] ...

                const SizedBox(height: 24.0),

                // 5. Headers Section
                _buildExpandableSection(
                  title: 'Headers (6)',
                  children: [
                    // Add your header content here, e.g.,
                    _buildDetailRow('Authorization:', 'Bearer token...'),
                    _buildDetailRow('Content-Type:', 'application/json'),
                    // ... more headers
                  ],
                ),
                const SizedBox(height: 24.0),

                // 6. Parameters Section
                _buildExpandableSection(
                  title: 'Parameters (10)',
                  children: [
                    // Parameter table
                    _buildParameterTable(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  // Helper function to build risk items
  Widget _buildRiskItem(
      IconData icon, Color color, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 20.0,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: children, // Add the content widgets here
    );
  }

  // Helper function to build the parameter table
  Widget _buildParameterTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2), // Parameter column
        1: FlexColumnWidth(2), // Changes column
        2: FlexColumnWidth(3), // Sensitive Data column
        3: FlexColumnWidth(2), // Type column
        4: FlexColumnWidth(2), // Updated column
      },
      children: [
        // Table Header Row
        TableRow(
          children: [
            _buildTableHeader('Parameter'),
            _buildTableHeader('Changes'),
            _buildTableHeader('Sensitive data'),
            _buildTableHeader('Type'),
            _buildTableHeader('Updated'),
          ],
        ),

        // Table Data Row
        TableRow(
          children: [
            _buildTableCell('{parameter_1} *', isHighlighted: true),
            _buildTableCell(''), // Empty cell under "Changes"
            _buildTableCell(''), // Empty cell under "Sensitive data"
            _buildTableCell('ASCII'),
            _buildTableCell('2 Nov, 2:21'),
          ],
        ),

        // Add more table rows for other parameters
      ],
    );
  }

  // Helper function to build table header cells
  Widget _buildTableHeader(String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[200], // Light grey background for header
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper function to build table data cells
  Widget _buildTableCell(String text, {bool isHighlighted = false}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isHighlighted ? Colors.red[100] : null, // Optional highlight
      ),
      child: Text(text),
    );
  }
}
