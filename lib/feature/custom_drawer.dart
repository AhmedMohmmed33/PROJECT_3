import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/auth/presentation/pages/login_page.dart';

class CustomDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemSelected;

  const CustomDrawer({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 28, 30, 47),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 28, 30, 47),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/driver.png',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Driver Monitoring',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Image.asset(
                        'assets/icons/x_mark.png',
                        width: 24,
                        height: 24,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'username',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'email@example.com',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Menu Items
          _buildDrawerItem(context, 0, 'Dashboard', 'active_car', 'inactive_car'),
          _buildDrawerItem(context, 1, 'Map', 'active_map', 'inactive_map'),
          _buildDrawerItem(context, 2, 'Alerts', 'active_alerts', 'inactive_alerts'),
          _buildDrawerItem(context, 3, 'Settings', 'active_settings', 'inactive_settings'),
          const Divider(color: Colors.grey),
          _buildSignOutItem(context),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    int index,
    String title,
    String activeIcon,
    String inactiveIcon,
  ) {
    return ListTile(
      leading: Image.asset(
        'assets/icons/${currentIndex == index ? activeIcon : inactiveIcon}.png',
        width: 24,
        height: 24,
        color: currentIndex == index 
            ? const Color.fromARGB(255, 0, 229, 255) 
            : Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: currentIndex == index 
              ? const Color.fromARGB(255, 0, 229, 255) 
              : Colors.white,
          fontWeight: currentIndex == index 
              ? FontWeight.bold 
              : FontWeight.normal,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // Close drawer first
        if (currentIndex != index) {
          onItemSelected(index);
        }
      },
    );
  }

  Widget _buildSignOutItem(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.red),
      title: const Text(
        'Sign Out',
        style: TextStyle(color: Colors.red),
      ),
      onTap: () {
        Navigator.pop(context); // Close drawer
        // Add sign out logic here
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false, // Remove all previous routes
        );
      },
    );
  }
}