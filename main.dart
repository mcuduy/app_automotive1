import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Automotive Demo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  double _fuelLevel = 0.3; // Set initial fuel level

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Fuel check',
      style: optionStyle,
    ),
    Text(
      'Check handbrake',
      style: optionStyle,
    ),
    Text(
      'Check my car',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToFuelCheck(BuildContext context) {
    if (_fuelLevel > 0.25) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FuelCheckScreen(fuelLevel: _fuelLevel)),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LowFuelScreen()),
      );
    }
  }

  void _navigateToCheckMyCar(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CarDiagnosticScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _widgetOptions[_selectedIndex],
            const SizedBox(height: 20),
            // Show fuel slider only on "Fuel" page
            if (_selectedIndex == 0) ...[
              Slider(
                value: _fuelLevel,
                min: 0,
                max: 1,
                divisions: 10,
                label: '${(_fuelLevel * 100).round()}%',
                onChanged: (double value) {
                  setState(() {
                    _fuelLevel = value; // Update the fuel level based on the slider
                  });
                },
              ),
              Text(
                'Fuel Level: ${(_fuelLevel * 100).round()}%',
                style: const TextStyle(fontSize: 24),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                if (_selectedIndex == 0) {
                  _navigateToFuelCheck(context);
                } else if (_selectedIndex == 2) { // Check my car
                  _navigateToCheckMyCar(context);
                } else {
                  print('Action button pressed for a different option!');
                }
              },
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Check Fuel Status'),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Checking options'),
            ),
            ListTile(
              leading: const Icon(Icons.local_gas_station),
              title: const Text('Fuel'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.handshake),
              title: const Text('Handbrake'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.car_repair),
              title: const Text('The whole system'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FuelCheckScreen extends StatelessWidget {
  final double fuelLevel; // Add a parameter to accept the fuel level

  const FuelCheckScreen({super.key, required this.fuelLevel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Check Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/fuel_full.png', width: 150, height: 150),
            const SizedBox(height: 20),
            Text(
              'Your vehicle is fueled and ready to go. Fuel level: ${fuelLevel.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

class LowFuelScreen extends StatelessWidget {
  const LowFuelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Low Fuel Warning'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/fuel_low.png', width: 150, height: 150),
            const SizedBox(height: 20),
            const Text(
              'Fuel level is low. Please refuel soon.',
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class CarDiagnosticScreen extends StatelessWidget {
  const CarDiagnosticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Diagnostic Systems'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.engineering),
            title: const Text('Engine System'),
            onTap: () {
              // Add functionality for the Engine System
            },
          ),
          ListTile(
            leading: const Icon(Icons.handshake),
            title: const Text('Braking System'),
            onTap: () {
              // Add functionality for the Braking System
            },
          ),
          ListTile(
            leading: const Icon(Icons.safety_check),
            title: const Text('Safety System'),
            onTap: () {
              // Add functionality for the Safety System
            },
          ),
          ListTile(
            leading: const Icon(Icons.monitor),
            title: const Text('Electrical System'),
            onTap: () {
              // Add functionality for the Electrical System
            },
          ),
          ListTile(
            leading: const Icon(Icons.tune),
            title: const Text('Transmission System'),
            onTap: () {
              // Add functionality for the Transmission System
            },
          ),
        ],
      ),
    );
  }
}
