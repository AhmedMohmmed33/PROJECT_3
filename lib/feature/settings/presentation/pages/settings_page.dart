import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/custom_drawer.dart';
import 'package:flutter_application_1/feature/auth/presentation/pages/login_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // Sign out confirmation dialog
  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Sign Out',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Are you sure you want to sign out?',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Close dialog and sign out
              Navigator.pop(context);
              _performSignOut(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Perform sign out actions
  void _performSignOut(BuildContext context) {
    // Clear user session and navigate to login
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(
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
      
      // FIX: Wrap body in SingleChildScrollView to prevent overflow
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Black Container
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Centered Header
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Account Settings',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Manage your account information',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                    
                    // Profile Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          // Profile Picture
                          Container(
                            width: 70,
                            height: 70,
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
                          // User Info
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'John Doe',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'john.doe@example.com',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.verified, color: Colors.green, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      'Verified Account',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Color.fromARGB(255, 0, 229, 255)),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Account Options
                    _buildOptionContainer(
                      icon: Icons.person,
                      text: 'Edit Profile',
                    ),
                    const SizedBox(height: 16),
                    _buildOptionContainer(
                      icon: Icons.lock,
                      text: 'Change Password',
                    ),
                    const SizedBox(height: 16),
                    _buildOptionContainer(
                      icon: Icons.notifications,
                      text: 'Notification Settings',
                    ),
                    const SizedBox(height: 16),
                    _buildOptionContainer(
                      icon: Icons.security,
                      text: 'Privacy & Security',
                    ),
                    const SizedBox(height: 30),
                    
                    // Sign Out Button
                    _buildOptionContainer(
                      icon: Icons.logout,
                      text: 'Sign Out',
                      color: Colors.red,
                      onTap: () => _showSignOutDialog(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              
              // App Settings Section
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'App Settings',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildOptionContainer(
                      icon: Icons.language,
                      text: 'Language',
                      trailing: const Text('English', style: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(height: 16),
                    _buildOptionContainer(
                      icon: Icons.dark_mode,
                      text: 'Dark Mode',
                      trailing: Switch(
                        value: true,
                        activeColor: const Color.fromARGB(255, 0, 229, 255),
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildOptionContainer(
                      icon: Icons.help,
                      text: 'Help & Support',
                    ),
                    const SizedBox(height: 16),
                    _buildOptionContainer(
                      icon: Icons.info,
                      text: 'About App',
                    ),
                  ],
                ),
              ),
            ],
          ),
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
    required IconData icon,
    required String text,
    Color color = const Color(0xFF1E1E1E),
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Row(
            children: [
              Icon(icon, color: color == Colors.red ? Colors.white : const Color.fromARGB(255, 0, 229, 255)),
              const SizedBox(width: 16),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: color == Colors.red ? Colors.white : Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (trailing != null) trailing,
              if (trailing == null && onTap != null)
                const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
