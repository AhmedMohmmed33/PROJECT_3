import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        currentIndex: currentIndex,
        onTap: onItemSelected,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 0, 229, 255),
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/${currentIndex == 0 ? 'active_car' : 'inactive_car'}.png',
              width: 24,
              height: 24,
              color: currentIndex == 0
                  ? const Color.fromARGB(255, 0, 229, 255)
                  : Colors.white,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/${currentIndex == 1 ? 'active_map' : 'inactive_map'}.png',
              width: 24,
              height: 24,
              color: currentIndex == 1
                  ? const Color.fromARGB(255, 0, 229, 255)
                  : Colors.white,
            ),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/${currentIndex == 2 ? 'active_alerts' : 'inactive_alerts'}.png',
              width: 24,
              height: 24,
              color: currentIndex == 2
                  ? const Color.fromARGB(255, 0, 229, 255)
                  : Colors.white,
            ),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/${currentIndex == 3 ? 'active_settings' : 'inactive_settings'}.png',
              width: 24,
              height: 24,
              color: currentIndex == 3
                  ? const Color.fromARGB(255, 0, 229, 255)
                  : Colors.white,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
