import 'dart:async'; // For StreamSubscription
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

  // Create a StreamSubscription to listen to gyroscope events
  late StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;

  @override
  void initState() {
    super.initState();
    // Start listening to the gyroscope stream using gyroscopeEventStream()
    _gyroscopeSubscription = gyroscopeEventStream().listen((
      GyroscopeEvent event,
    ) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      });
    });
  }

  @override
  void dispose() {
    // Always cancel the stream subscription when the widget is disposed to avoid memory leaks
    _gyroscopeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gyroscope Sensor Values"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'X: ${x.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                'Y: ${y.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                'Z: ${z.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Text(
                'Move your phone to see the values change!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
