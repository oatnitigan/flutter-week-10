import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double x = 0, y = 0, z = 0;

  late StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;

  // To track the position of the circle on screen
  double circleX = 0.0;
  double circleY = 0.0;

  @override
  void initState() {
    super.initState();
    // Listen to the gyroscope events stream
    _gyroscopeSubscription = gyroscopeEventStream().listen((
      GyroscopeEvent event,
    ) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;

        // Update circle position based on gyroscope X and Y values
        // We use a multiplier to scale the gyroscope values to move the circle within screen bounds
        circleX +=
            x * 10; // You can adjust this multiplier for more/less sensitivity
        circleY -= y * 10; // Invert to match natural movement

        // Keep the circle inside screen bounds
        circleX = circleX.clamp(
          0.0,
          MediaQuery.of(context).size.width - 100,
        ); // 100 is the circle size
        circleY = circleY.clamp(
          0.0,
          MediaQuery.of(context).size.height - 100,
        ); // 100 is the circle size
      });
    });
  }

  @override
  void dispose() {
    // Cancel the gyroscope event subscription when the widget is disposed
    _gyroscopeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gyroscope-Controlled Circle"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          // Circle that moves based on gyroscope
          Positioned(
            left: circleX,
            top: circleY,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Optional: Show gyroscope values for debugging
          Positioned(
            bottom: 30,
            left: 30,
            child: Text(
              'X: ${x.toStringAsFixed(2)}  Y: ${y.toStringAsFixed(2)}  Z: ${z.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
