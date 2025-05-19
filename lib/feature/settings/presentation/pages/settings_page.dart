import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/custom_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer:  CustomDrawer(
        currentIndex: 3,
        onItemSelected: (index) {
          if (index != 3) {
            Navigator.pushReplacementNamed(context, _getRouteName(index));
          }
        },
      ),
      appBar: AppBar(
        title: const Text(
          'Settings',
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
      
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Black Container
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Centered Header
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        'Account',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Manage your account settings',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  
                  // User Info Section with Profile Picture
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Picture
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[800],
                        image: const DecorationImage(
                          image: AssetImage('assets/images/profile_placeholder.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Username & Email
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'username', // Replace with actual username
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'email@example.com', // Replace with actual email
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),                
                  const SizedBox(height: 30),
                  
                  // Edit Profile Button
                  _buildOptionContainer(
                    text: 'Edit Profile',
                    color: Colors.grey[900]!,
                  ),
                  const SizedBox(height: 16),
                  
                  // Change Password Button
                  _buildOptionContainer(
                    text: 'Change Password',
                    color: Colors.grey[900]!,
                  ),
                  const SizedBox(height: 30),
                  
                  // Sign Out Button
                  _buildOptionContainer(                  
                    text: 'Sign Out',
                    color: Colors.red,
                    textColor: Colors.white,
                    icon: Icons.logout,
                  ),
                  const SizedBox(height: 30),
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
      case 0:
        return '/dashboard';
      case 1:
        return '/map';
      case 2:
        return '/alerts';
      default:
        return '/settings';
    }
  }

  Widget _buildOptionContainer({
    required String text,
    required Color color,
    Color textColor = Colors.white,
    IconData? icon,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          if (text == 'Sign Out') {
            // Handle sign out
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (icon != null)
                Icon(
                  icon,
                  color: textColor,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
