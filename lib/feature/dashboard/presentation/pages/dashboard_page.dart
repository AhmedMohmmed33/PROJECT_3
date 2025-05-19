import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/alerts/presentation/pages/alerts_page.dart';
import 'package:flutter_application_1/feature/map/presentation/pages/map_page.dart';
import 'package:flutter_application_1/feature/settings/presentation/pages/settings_page.dart';
import 'package:flutter_application_1/feature/custom_drawer.dart';


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
      floatingActionButton: _currentIndex == 0 
        ? FloatingActionButton(
            onPressed: () {},
            backgroundColor: const Color.fromARGB(255, 0, 229, 255),
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
          )
        : null,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromARGB(255, 0, 229, 255),
          unselectedItemColor: Colors.white, // Changed from white to grey
          backgroundColor: Colors.black,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/${_currentIndex == 0 ? 'active_car' : 'inactive_car'}.png',
                width: 24,
                height: 24,
                color: _currentIndex == 0 
                    ? const Color.fromARGB(255, 0, 229, 255) 
                    : Colors.white,
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/${_currentIndex == 1 ? 'active_map' : 'inactive_map'}.png',
                width: 24,
                height: 24,
                color: _currentIndex == 1 
                    ? const Color.fromARGB(255, 0, 229, 255) 
                    : Colors.white,
              ),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/${_currentIndex == 2 ? 'active_alerts' : 'inactive_alerts'}.png',
                width: 24,
                height: 24,
                color: _currentIndex == 2 
                    ? const Color.fromARGB(255, 0, 229, 255) 
                    : Colors.white,
              ),
              label: 'Alerts',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/${_currentIndex == 3 ? 'active_settings' : 'inactive_settings'}.png',
                width: 24,
                height: 24,
                color: _currentIndex == 3 
                    ? const Color.fromARGB(255, 0, 229, 255) 
                    : Colors.white,
              ),
              label: 'Settings',
            ),
          ],
        ),
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
                name: 'Canny Sedan',
                status: 'Driving',
                statusColor: Color(0xFF4CAF50),
                imagePath: 'assets/images/car1.webp',
              ),
              SizedBox(height: 16),
              VehicleCard(
                name: 'Honda SUV',
                status: 'Parked',
                statusColor: Color(0xFF2196F3),
                imagePath: 'assets/images/car2.webp',
              ),
              SizedBox(height: 16),
              VehicleCard(
                name: 'BMW X3 M50',
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
          // Navigate to vehicle details
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