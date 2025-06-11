import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/map/presentation/pages/map_page.dart';

class VehicleDetailsPage extends StatefulWidget {
  final String vehicleName;
  final String status;
  final Color statusColor;
  final String imagePath;

  const VehicleDetailsPage({
    super.key,
    required this.vehicleName,
    required this.status,
    required this.statusColor,
    required this.imagePath,
  });

  @override
  State<VehicleDetailsPage> createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  bool showOverview = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Vehicle Details',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Vehicle Image
            ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.asset(
                widget.imagePath,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            // Vehicle Name, Status, and Track Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.vehicleName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    backgroundColor: widget.statusColor.withOpacity(0.2),
                    label: Text(
                      widget.status,
                      style: TextStyle(color: widget.statusColor),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MapPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    icon: const Icon(Icons.gps_fixed),
                    label: const Text('Track'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Toggle Buttons: Overview / Trips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => showOverview = true),
                      child: Container(
                        decoration: BoxDecoration(
                          color: showOverview ? Colors.black : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: Text(
                          'Overview',
                          style: TextStyle(
                            color: showOverview ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => showOverview = false),
                      child: Container(
                        decoration: BoxDecoration(
                          color: !showOverview ? Colors.black : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: Text(
                          'Trips',
                          style: TextStyle(
                            color: !showOverview ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Animated Dynamic Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation);
                  return SlideTransition(position: offsetAnimation, child: child);
                },
                child: showOverview
                    ? _buildOverview().withKey(const ValueKey('overview'))
                    : _buildTrips().withKey(const ValueKey('trips')),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildOverview() {
    final time = DateTime.now();
    final formattedTime =
        '${time.hour > 12 ? time.hour - 12 : time.hour}:${time.minute.toString().padLeft(2, '0')} ${time.hour < 12 ? 'AM' : 'PM'}';

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _infoTile(
                  Image.asset('assets/icons/fuel.png', width: 24, height: 24),
                  'Fuel Level',
                  '80%',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _infoTile(
                  Image.asset('assets/icons/speedometer.png', width: 24, height: 24),
                  'Driving Score',
                  '83',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _infoTile(
                  Image.asset('assets/icons/speedometer.png', width: 24, height: 24),
                  'Speed',
                  '31 mph',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _infoTile(
                  const Icon(Icons.access_time, size: 24, color: Colors.black),
                  'Last Update',
                  formattedTime,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



  Widget _buildTrips() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Trips',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          _tripCard('5/12/2025 • 3:08 AM', '83', ['Aggressive Driving', 'Normal Driving']),
          const SizedBox(height: 16),
          _tripCard('5/12/2025 • 3:06 AM', '70', ['Aggressive Driving', 'Normal Driving', 'Distracted']),
          const SizedBox(height: 16),
          _tripCard('5/12/2025 • 3:06 AM', '67', ['Normal Driving', 'Distracted']),
        ],
      ),
    );
  }


  Widget _infoTile(Widget iconWidget, String title, String value) {
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
          iconWidget,
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }


  Widget _tripCard(String time, String score, List<String> tags) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Card(
        color:  Colors.white,
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
                  Text(time, style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text(
                    score,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
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
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}

extension WidgetKey on Widget {
  Widget withKey(Key key) => KeyedSubtree(key: key, child: this);
}
