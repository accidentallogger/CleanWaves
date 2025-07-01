import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'AddEventScreen.dart';
import 'ConfigColors.dart';

class CleanupTab extends StatelessWidget {
  const CleanupTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appcolors.appBarColor,
        title: Center(
          child: const Text(
            'Cleanup Events',
            style: TextStyle(
              color: appcolors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with actual events list length
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            color: Colors.blueAccent.withOpacity(0.2),
            child: ListTile(
              leading: Container(
                child: SizedBox(child: Image.asset("assets/placeholder.jpg")),
              ),
              title: Text(
                'Cleanup Event ${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                'Date: 2025-07-01 | Status: Ongoing',
                style: TextStyle(color: appcolors.subtextcolor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: appcolors.buttonColor,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EventDetailScreen()),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appcolors.buttonColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEventScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> pie = [
      ChartData("Attending", 25),
      ChartData("Total", 90),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Event Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              height: 200,
              color: appcolors.secondarybgcolor,
              child: const Center(
                child: Text(
                  "Event Banner",
                  style: TextStyle(color: appcolors.textColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Date: 2025-07-01\nTime: 9:00 AM - 12:00 PM\nPlace: Juhu Beach\nStatus: Ongoing",
              style: TextStyle(color: appcolors.textColor),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 10),
                Text(
                  "Organizer Name",
                  style: TextStyle(
                    color: appcolors.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Short description of the event goes here.Short description of the event goes here.Short description of the event goes here.Short description of the event goes here.Short description of the event goes here.Short description of the event goes here.Short description of the event goes here.Short description of the event goes here.",
              style: TextStyle(color: appcolors.subtextcolor),
            ),
            const SizedBox(height: 16),
            SfCircularChart(
              series: <CircularSeries>[
                PieSeries<ChartData, String>(
                  dataSource: pie,
                  pointColorMapper: (ChartData d, _) => d.color,
                  xValueMapper: (ChartData d, _) => d.x,
                  yValueMapper: (ChartData d, _) => d.y,
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Participate",
                style: TextStyle(color: appcolors.textColor),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share, color: appcolors.textColor),
                  label: const Text(
                    "Share",
                    style: TextStyle(color: appcolors.textColor),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.directions,
                    color: appcolors.textColor,
                  ),
                  label: const Text(
                    "See Map",
                    style: TextStyle(color: appcolors.textColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
