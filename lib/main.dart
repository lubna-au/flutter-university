import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Single-file demo app with 5 tabs:
/// 1) Welcome screen (yellow bg, blue text, size 24)
/// 2) Row: 3 evenly spaced buttons
/// 3) Stack: overlay text on an image
/// 4) Puppy image grows (doubles size) on button press
/// 5) Profile screen using Row & Column
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Multi-Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _titles = [
    'Welcome',
    'Row Buttons',
    'Stack Overlay',
    'Puppy Grow',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      const WelcomeScreen(),
      const RowButtonsScreen(),
      const StackOverlayScreen(),
      const PuppyGrowScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(_titles[_index])),
      body: screens[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Welcome'),
          NavigationDestination(icon: Icon(Icons.view_week_outlined), selectedIcon: Icon(Icons.view_week), label: 'Row'),
          NavigationDestination(icon: Icon(Icons.layers_outlined), selectedIcon: Icon(Icons.layers), label: 'Stack'),
          NavigationDestination(icon: Icon(Icons.pets_outlined), selectedIcon: Icon(Icons.pets), label: 'Puppy'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

/// 1) Welcome screen (yellow bg, blue text 24, centered)
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      width: double.infinity,
      height: double.infinity,
      child: const Center(
        child: Text(
          'Welcome to Flutter',
          style: TextStyle(
            fontSize: 24,
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// 2) Row with three evenly spaced buttons
class RowButtonsScreen extends StatelessWidget {
  const RowButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(onPressed: () {}, child: const Text('Button 1')),
          ElevatedButton(onPressed: () {}, child: const Text('Button 2')),
          ElevatedButton(onPressed: () {}, child: const Text('Button 3')),
        ],
      ),
    );
  }
}

/// 3) Stack overlay: text on top of an image
class StackOverlayScreen extends StatelessWidget {
  const StackOverlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Using a public sample image from Flutter docs
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
              width: 320,
              height: 220,
              fit: BoxFit.cover,
            ),
          ),
          const Text(
            'Hello Flutter',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              backgroundColor: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

/// 4) Puppy image that doubles in size on each press
class PuppyGrowScreen extends StatefulWidget {
  const PuppyGrowScreen({super.key});

  @override
  State<PuppyGrowScreen> createState() => _PuppyGrowScreenState();
}

class _PuppyGrowScreenState extends State<PuppyGrowScreen> {
  double _size = 120;

  // Optional: to avoid going *too* huge during demos
  static const double _maxSize = 1200;

  void _doubleSize() {
    setState(() {
      _size = (_size * 2).clamp(60, _maxSize);
    });
  }

  void _resetSize() {
    setState(() => _size = 120);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                width: _size,
                height: _size,
                child: Image.network(
                  // Puppy placeholder image
                  'https://images.unsplash.com/photo-1543466835-00a7907e9de1?q=80&w=1200&auto=format&fit=crop',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FilledButton.icon(
              onPressed: _doubleSize,
              icon: const Icon(Icons.zoom_in),
              label: const Text('Double Size'),
            ),
            OutlinedButton.icon(
              onPressed: _resetSize,
              icon: const Icon(Icons.restore),
              label: const Text('Reset'),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

/// 5) Profile screen using Rows & Columns
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header row: avatar + name/title
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 36,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=600&auto=format&fit=crop',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Lubna Aubdoolary',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    SizedBox(height: 4),
                    Text('BSc (Hons) Applied Computing',
                        style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                tooltip: 'Edit Profile',
              )
            ],
          ),
          const SizedBox(height: 20),

          // Stats row
          Container(
            decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(0.06),
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _StatItem(label: 'Followers', value: '9k'),
                _DividerDot(),
                _StatItem(label: 'Following', value: '120'),
                _DividerDot(),
                _StatItem(label: 'Projects', value: '14'),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // About section (Column of rows)
          Align(
            alignment: Alignment.centerLeft,
            child: Text('About',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 8),
          const _InfoRow(icon: Icons.location_on, label: 'Location', value: 'Mauritius'),
          const _InfoRow(icon: Icons.school, label: 'University', value: 'UoM'),
          const _InfoRow(icon: Icons.code, label: 'Interests', value: 'Flutter, React, UI/UX'),

          const SizedBox(height: 20),

          // Action row
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.message),
                  label: const Text('Message'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.person_add_alt),
                  label: const Text('Follow'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }
}

class _DividerDot extends StatelessWidget {
  const _DividerDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black26),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.indigo),
          const SizedBox(width: 10),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}