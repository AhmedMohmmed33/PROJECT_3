import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/alerts/presentation/pages/alerts_page.dart';
import 'package:flutter_application_1/feature/map/presentation/pages/map_page.dart';
import 'package:flutter_application_1/feature/settings/presentation/pages/settings_page.dart';
import 'package:flutter_application_1/feature/custom_drawer.dart';
import 'package:flutter_application_1/feature/vehicle_details/presentation/pages/vehicle_details_page.dart';
import 'package:flutter_application_1/feature/custom_buttom_nav.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const MyVehiclesPage(),
    const MapPage(),
    const AlertsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(
        currentIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
        },
      ),// Changed to black
      body: _pages[_currentIndex],
      
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),

      
    );
  }
  

  
}

class MyVehiclesPage extends StatelessWidget {
  const MyVehiclesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Remove the Scaffold wrapper and return just the content
    return Column(
      children: [
        AppBar(
          title: const Text(
            'My Vehicles',
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
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          actions: [
            IconButton(
              icon: Image.asset(
                'assets/icons/search.png',
                width: 30,
                height: 30,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              VehicleCard(
                name: 'BMW X3 M50',
                status: 'Driving',
                statusColor: Color(0xFF4CAF50),
                imagePath: 'assets/images/car1.webp',
              ),
              SizedBox(height: 16),
              VehicleCard(
                name: 'Canny Sedan',
                status: 'Parked',
                statusColor: Color(0xFF2196F3),
                imagePath: 'assets/images/car2.webp',
              ),
              SizedBox(height: 16),
              VehicleCard(
                name: 'Honda SUV',
                status: 'Driving',
                statusColor: Color(0xFF4CAF50),
                imagePath: 'assets/images/car3.jpeg',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class VehicleCard extends StatelessWidget {
  final String name;
  final String status;
  final Color statusColor;
  final String imagePath;

  const VehicleCard({
    super.key,
    required this.name,
    required this.status,
    required this.statusColor,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.black, // Changed to dark grey
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VehicleDetailsPage(
                vehicleName: name,
                status: status,
                statusColor: statusColor,
                imagePath: imagePath,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  width: 200,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white, // Changed to white
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          status,
                          style: TextStyle(
                            color: statusColor, // Changed to use statusColor
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[200],
              ),
            ],
          ),
        ),
      ),
    );
  }
}