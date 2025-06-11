import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/custom_drawer.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _offset = Offset.zero;
  Offset _previousOffset = Offset.zero;
  List<MapMarker> markers = [];

  @override
  void initState() {
    super.initState();
    // Add initial markers
    markers = [
      MapMarker(
        position: const Offset(0.3, 0.4),
        label: 'Your Vehicle',
        color: Colors.blue,
      ),
      MapMarker(
        position: const Offset(0.7, 0.6),
        label: 'Destination',
        color: Colors.green,
      ),
      MapMarker(
        position: const Offset(0.5, 0.2),
        label: 'Service Station',
        color: Colors.orange,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
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
      body: GestureDetector(
        onScaleStart: (details) {
          _previousScale = _scale;
          _previousOffset = details.focalPoint;
        },
        onScaleUpdate: (details) {
          setState(() {
            _scale = _previousScale * details.scale;
            
            // Calculate translation
            final currentFocal = details.focalPoint;
            final delta = currentFocal - _previousOffset;
            _offset += delta / _scale;
            _previousOffset = currentFocal;
          });
        },
        onScaleEnd: (details) {
          _previousScale = _scale;
          _previousOffset = Offset.zero;
        },
        onTapDown: (details) {
          final renderBox = context.findRenderObject() as RenderBox;
          final localPosition = renderBox.globalToLocal(details.globalPosition);
          final size = renderBox.size;
          
          // Calculate position relative to map (0.0-1.0)
          final relativePosition = Offset(
            (localPosition.dx - _offset.dx * _scale) / (size.width * _scale),
            (localPosition.dy - _offset.dy * _scale) / (size.height * _scale),
          );
          
          // Add a new marker at tap position
          setState(() {
            markers.add(MapMarker(
              position: relativePosition,
              label: 'Point ${markers.length + 1}',
              color: Colors.primaries[markers.length % Colors.primaries.length],
            ));
          });
        },
        child: CustomPaint(
          painter: VirtualMapPainter(
            offset: _offset,
            scale: _scale,
            markers: markers,
          ),
          size: Size.infinite,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => setState(() => _scale = (_scale * 1.2).clamp(0.5, 5.0)),
            mini: true,
            backgroundColor: Colors.white,
            child: const Icon(Icons.add, color: Colors.black),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => setState(() => _scale = (_scale * 0.8).clamp(0.5, 5.0)),
            mini: true,
            backgroundColor: Colors.white,
            child: const Icon(Icons.remove, color: Colors.black),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => setState(() {
              _scale = 1.0;
              _offset = Offset.zero;
            }),
            mini: true,
            backgroundColor: Colors.white,
            child: const Icon(Icons.refresh, color: Colors.black),
          ),
        ],
      ),
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

class MapMarker {
  final Offset position;
  final String label;
  final Color color;

  MapMarker({
    required this.position,
    required this.label,
    this.color = Colors.blue,
  });
}

class VirtualMapPainter extends CustomPainter {
  final Offset offset;
  final double scale;
  final List<MapMarker> markers;

  VirtualMapPainter({
    required this.offset,
    required this.scale,
    required this.markers,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Apply transformations
    canvas.translate(offset.dx * scale, offset.dy * scale);
    canvas.scale(scale);
    
    // Draw map background
    final backgroundPaint = Paint()..color = const Color(0xFFE9F5F9);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);
    
    // Draw roads
    final roadPaint = Paint()
      ..color = Colors.grey[800]!
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;
    
    // Main roads
    canvas.drawLine(
      Offset(0, size.height * 0.3),
      Offset(size.width, size.height * 0.3),
      roadPaint,
    );
    
    canvas.drawLine(
      Offset(size.width * 0.5, 0),
      Offset(size.width * 0.5, size.height),
      roadPaint,
    );
    
    // Secondary roads
    final secondaryRoadPaint = Paint()
      ..color = Colors.grey[600]!
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.1),
      Offset(size.width * 0.2, size.height * 0.7),
      secondaryRoadPaint,
    );
    
    canvas.drawLine(
      Offset(size.width * 0.7, size.height * 0.5),
      Offset(size.width * 0.7, size.height * 0.9),
      secondaryRoadPaint,
    );
    
    canvas.drawLine(
      Offset(size.width * 0.3, size.height * 0.6),
      Offset(size.width * 0.8, size.height * 0.6),
      secondaryRoadPaint,
    );
    
    // Draw buildings
    final buildingPaint = Paint()..color = Colors.grey[400]!;
    final buildingSize = size.width * 0.05;
    
    for (int i = 0; i < 30; i++) {
      final x = (i % 6) * size.width / 6 + buildingSize * 0.5;
      final y = (i ~/ 6) * size.height / 5 + buildingSize * 0.5;
      
      // Skip roads
      if ((y > size.height * 0.25 && y < size.height * 0.35) || 
          (x > size.width * 0.45 && x < size.width * 0.55)) {
        continue;
      }
      
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(x, y),
          width: buildingSize,
          height: buildingSize * 1.5,
        ),
        buildingPaint,
      );
    }
    
    // Draw parks/green areas
    final parkPaint = Paint()..color = const Color(0xFFA5D6A7);
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width * 0.8, size.height * 0.2),
        width: size.width * 0.15,
        height: size.width * 0.15,
      ),
      parkPaint,
    );
    
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width * 0.3, size.height * 0.8),
        width: size.width * 0.2,
        height: size.width * 0.1,
      ),
      parkPaint,
    );
    
    // Draw markers
    for (var marker in markers) {
      final position = Offset(
        marker.position.dx * size.width,
        marker.position.dy * size.height,
      );
      
      // Draw marker pin
      final markerPaint = Paint()..color = marker.color;
      canvas.drawCircle(position, 15, markerPaint);
      
      // Draw marker outline
      final outlinePaint = Paint()
        ..color = Colors.white
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(position, 15, outlinePaint);
      
      // Draw marker label background
      final textBackgroundRect = Rect.fromCenter(
        center: position + const Offset(0, -35),
        width: marker.label.length * 10.0,
        height: 25,
      );
      
      final backgroundPaint = Paint()
        ..color = marker.color
        ..style = PaintingStyle.fill;
      canvas.drawRRect(
        RRect.fromRectAndRadius(textBackgroundRect, const Radius.circular(12)),
        backgroundPaint,
      );
      
      // Draw marker label
      final textPainter = TextPainter(
        text: TextSpan(
          text: marker.label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      
      textPainter.paint(
        canvas,
        textBackgroundRect.center - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }
    
    // Draw compass
    final compassPaint = Paint()
      ..color = Colors.blueGrey[800]!
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width - 40, 40), 25, compassPaint);
    
    final compassText = TextPainter(
      text: const TextSpan(
        text: 'N',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    
    compassText.paint(
      canvas,
      Offset(size.width - 40 - compassText.width / 2, 40 - compassText.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant VirtualMapPainter oldDelegate) {
    return offset != oldDelegate.offset ||
        scale != oldDelegate.scale ||
        markers != oldDelegate.markers;
  }
}