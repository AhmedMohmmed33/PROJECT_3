import 'package:flutter/material.dart';

import 'package:flutter_application_1/feature/custom_drawer.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer:  CustomDrawer(
        currentIndex: 2,
        onItemSelected: (index) {
          if (index != 2) {
            Navigator.pushReplacementNamed(context, _getRouteName(index));
          }
        },
      ),
       // Light grey background
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
            icon: Image.asset('assets/icons/menu.png',
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
            // Alerts Container
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(

                children: [
                  const SizedBox(height: 12),
                  // Header Section
                  const Text(
                  'Recent Driving Alerts',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
              'Monitoring alerts from all vehicles in your fleet',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
                  _buildAlertCard(
                    alertType: 'Normal Driving',
                    vehicle: 'Work Sedan',
                    time: '5/12/2025 ● 3:08 AM',
                    isNormal: true,
                  ),
                  const SizedBox(height: 12),
                  _buildAlertCard(
                    alertType: 'Aggressive Driving',
                    vehicle: 'Work Sedan',
                    time: '5/12/2025 ● 3:07 AM',
                    isNormal: false,
                  ),
                  const SizedBox(height: 12),
                  _buildAlertCard(
                    alertType: 'Distracted',
                    vehicle: 'Work Sedan',
                    time: '5/12/2025 ● 3:06 AM',
                    isNormal: false,
                  ),
                  const SizedBox(height: 12),
                  _buildAlertCard(
                    alertType: 'Normal Driving',
                    vehicle: 'Work Sedan',
                    time: '5/12/2025 ● 3:08 AM',
                    isNormal: true,
                  ),
                  const SizedBox(height: 12),
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

  Widget _buildAlertCard({
    required String alertType,
    required String vehicle,
    required String time,
    required bool isNormal,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            alertType,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isNormal ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            vehicle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}