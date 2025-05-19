import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/custom_drawer.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  CustomDrawer(
        currentIndex: 1,
        onItemSelected: (index) {
          if (index != 1) {
            Navigator.pushReplacementNamed(context, _getRouteName(index));
          }
        },
      ),
      appBar: AppBar(
        title: const Text(
          'Map',
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
              color: Colors.black,),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: const Center(child: Text('Map Content')),
    );
  }

  static String _getRouteName(int index) {
    switch (index) {
      case 0: return '/dashboard';
      case 2: return '/alerts';
      case 3: return '/settings';
      default: return '/map';
    }
  }
}