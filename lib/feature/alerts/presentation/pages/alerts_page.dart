import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/custom_drawer.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(
        currentIndex: 2,
        onItemSelected: (index) {
          if (index != 2) {
            Navigator.pushReplacementNamed(context, _getRouteName(index));
          }
        },
      ),
      appBar: AppBar(
        title: const Text(
          'Alerts',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Image.asset(
              'assets/icons/menu.png',
              width: 30,
              height: 30,
              color: Colors.black,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            const Row(
              children: [
                Expanded(
                  child: _InfoTile(
                    icon: Icon(Icons.warning_amber, color: Colors.red),
                    title: 'Critical Alerts',
                    value: '3',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _InfoTile(
                    icon: Icon(Icons.notifications_active, color: Colors.orange),
                    title: 'Warnings',
                    value: '7',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Alerts Container
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Driving Alerts',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _alertCard(
                    time: '5/12/2025 • 3:08 AM',
                    vehicle: 'Work Sedan',
                    tags: ['Normal Driving'],
                    isCritical: false,
                  ),
                  const SizedBox(height: 16),
                  _alertCard(
                    time: '5/12/2025 • 3:07 AM',
                    vehicle: 'BMW X3 M50',
                    tags: ['Aggressive Driving'],
                    isCritical: true,
                  ),
                  const SizedBox(height: 16),
                  _alertCard(
                    time: '5/12/2025 • 3:06 AM',
                    vehicle: 'Honda SUV',
                    tags: ['Distracted', 'Speeding'],
                    isCritical: true,
                  ),
                  const SizedBox(height: 16),
                  _alertCard(
                    time: '5/12/2025 • 3:05 AM',
                    vehicle: 'Canny Sedan',
                    tags: ['Normal Driving'],
                    isCritical: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _getRouteName(int index) {
    switch (index) {
      case 0: return '/dashboard';
      case 1: return '/map';
      case 3: return '/settings';
      default: return '/alerts';
    }
  }

  Widget _alertCard({
    required String time,
    required String vehicle,
    required List<String> tags,
    required bool isCritical,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    time, 
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    vehicle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isCritical ? Colors.red : Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: tags.map((tag) => _buildTag(tag)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    Color color;
    switch (text) {
      case 'Aggressive Driving':
        color = Colors.red;
        break;
      case 'Normal Driving':
        color = Colors.green;
        break;
      case 'Distracted':
        color = Colors.orange;
        break;
      case 'Speeding':
        color = Colors.purple;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white, 
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final Widget icon;
  final String title;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}