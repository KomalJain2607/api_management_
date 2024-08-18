import 'package:api_management_/widgets/api_details_page.dart';
import 'package:flutter/material.dart';

class ApiEndpointsList extends StatefulWidget {
  const ApiEndpointsList({super.key});

  @override
  _ApiEndpointsListState createState() => _ApiEndpointsListState();
}

class _ApiEndpointsListState extends State<ApiEndpointsList> {
  String activeTab = 'All endpoints';
  bool isAscending = true;
  String sortedColumn = 'endpoint';
  bool _showApiDetails = false;
  Map<String, dynamic>? _selectedApi;

  final List<Map<String, dynamic>> allEndpoints = [
    {
      'endpoint': '/api/v2/user/{parameter_1}/history',
      'risk': 'Non Sensitive',
      'hits': 39700
    },
    {
      'endpoint': '/api/v2/payment/{parameter_1}',
      'risk': 'Highly Sensitive',
      'hits': 33700
    },
    {
      'endpoint': '/api/v2/allocation/submission/{parameter_1}',
      'risk': 'Sensitive',
      'hits': 32800
    },
    {'endpoint': '/oauth/token', 'risk': 'Sensitive', 'hits': 29400},
    {'endpoint': '/v2/messages', 'risk': 'Sensitive', 'hits': 28400},
  ];

  List<Map<String, dynamic>> get displayedEndpoints {
    switch (activeTab) {
      case 'New endpoints':
        return allEndpoints
            .where((api) => api['risk'] == 'Highly Sensitive')
            .toList();
      case 'Shadow':
        return allEndpoints
            .where((api) => api['risk'] == 'Non Sensitive')
            .toList();
      default:
        return allEndpoints;
    }
  }

  void sortList(String column) {
    setState(() {
      if (sortedColumn == column) {
        isAscending = !isAscending;
      } else {
        sortedColumn = column;
        isAscending = true;
      }

      displayedEndpoints.sort((a, b) {
        int compare;
        if (column == 'endpoint') {
          compare = a[column].compareTo(b[column]);
        } else {
          compare = a[column].compareTo(b[column]);
        }
        return isAscending ? compare : -compare;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'API endpoints by risk',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _buildTab('All endpoints', activeTab == 'All endpoints'),
                  _buildTab('New endpoints', activeTab == 'New endpoints'),
                  _buildTab('Shadow', activeTab == 'Shadow'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _buildColumnHeaders(),
            Expanded(
              child: ListView.builder(
                itemCount: displayedEndpoints.length,
                itemBuilder: (context, index) {
                  return _buildApiRow(
                      context, displayedEndpoints[index]); // Pass context
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) => setState(() {}),
        onExit: (event) => setState(() {}),
        child: GestureDetector(
          onTap: () {
            setState(() {
              activeTab = label;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isActive ? Colors.orange : Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                          color: Colors.orange.withOpacity(0.5), blurRadius: 4)
                    ]
                  : [],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColumnHeaders() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          _buildSortableColumn('Endpoints', 'endpoint'),
          SizedBox(width: 200),
          _buildSortableColumn('Risk', 'risk'),
          SizedBox(width: 85),
          _buildSortableColumn('Hits', 'hits'),
        ],
      ),
    );
  }

  Widget _buildSortableColumn(String label, String column) {
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => sortList(column),
          child: Container(
            // <-- Added Container here
            alignment: Alignment.centerLeft, // Align content to the left
            child: Row(
              mainAxisSize: MainAxisSize.min, // Prevent Row from stretching
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: sortedColumn == column ? Colors.blue : Colors.black,
                  ),
                ),
                const SizedBox(width: 4), // Small space between text and icon
                Icon(
                  sortedColumn == column
                      ? (isAscending
                          ? Icons.arrow_upward
                          : Icons.arrow_downward)
                      : Icons.unfold_more,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildApiRow(BuildContext context, Map<String, dynamic> api) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _showApiDetails = true;
          _selectedApi = api;
        });
      },
      onExit: (_) {
        setState(() {
          _showApiDetails = false;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _navigateToDetailsPage(context, api);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: <Widget>[
              Expanded(
                // Endpoint Column
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      api['endpoint'],
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Text(
                      'main-api.eu.demo.wallarm.tools',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Expanded(
                // Risk Column - Improved Structure
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100.0), // Consistent padding
                  child: _buildRisk(api['risk']),
                ),
              ),
              Expanded(
                // Hits Column - Improved Structure
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100.0), // Consistent padding
                  child: Text('${api['hits'] ~/ 1000}K'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetailsPage(BuildContext context, Map<String, dynamic> api) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApiDetailsPage(api: api), // Pass api data
      ),
    );
  }

  Widget _buildRisk(String risk) {
    Color color;
    if (risk == 'Highly Sensitive') {
      color = Colors.red;
    } else if (risk == 'Sensitive') {
      color = Colors.orange;
    } else {
      color = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        risk,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
