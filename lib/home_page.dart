import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'fullscreen_map_page.dart';
import 'cleanup_tab.dart';
import 'learning_hub.dart';
import 'Profile.dart';
import 'ConfigColors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    // Placeholder for cleanup tab
    Center(child: const CleanupTab()),
    // Placeholder for learning hub
    Center(child: const LearningHub()),
    // Placeholder for profile
    Center(child: Profile()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: appcolors.appBarColor,
        selectedItemColor: appcolors.buttonColor,
        unselectedItemColor: appcolors.unselectedcolor,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.cleaning_services),
            label: 'Cleanup',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Learning'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appcolors.appBarColor,
        title: Center(
          child: Text(
            "Home",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: appcolors.textColor,
            ),
          ),
        ),
      ),
      backgroundColor: appcolors.backgroColor,
      body: ListView(
        children: [
          SizedBox(
            height: 50,

            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: const Text(
                "Upcoming events",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SizedBox(height: 5),
          Stack(
            children: [
              SizedBox(
                height: 200,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(19.1048, 72.8247),
                    initialZoom: 14,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(19.1048, 72.8247),
                          width: 30,
                          height: 30,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appcolors.buttonColor.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FullscreenMapPage(),
                      ),
                    );
                  },
                  child: const Icon(Icons.map, color: appcolors.textColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Community Posts",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...List.generate(
            3,
            (index) => Card(
              color: appcolors.buttonColor.withOpacity(0.2),
              margin: const EdgeInsets.all(8),

              child: ListTile(
                title: Text(
                  "Post ${index + 1}",
                  style: const TextStyle(color: appcolors.textColor),
                ),
                subtitle: const Text(
                  "This is a community post.",
                  style: TextStyle(color: appcolors.subtextcolor),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "News",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...List.generate(
            2,
            (index) => Card(
              color: appcolors.buttonColor.withOpacity(0.2),
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(
                  "News ${index + 1}",
                  style: TextStyle(color: appcolors.textColor),
                ),
                subtitle: const Text(
                  "This is a news item.",
                  style: TextStyle(color: appcolors.descriptioncolor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
