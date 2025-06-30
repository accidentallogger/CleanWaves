import 'package:flutter/material.dart';

class CleanupTab extends StatelessWidget {
  const CleanupTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cleanup Events')),
      body: ListView.builder(
        itemCount: 5, // Replace with actual events list length
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            color: Colors.grey[900],
            child: ListTile(
              title: Text(
                'Cleanup Event ${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                'Date: 2025-07-01 | Status: Ongoing',
                style: TextStyle(color: Colors.white70),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.blueAccent,
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
        backgroundColor: Colors.blueAccent,
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

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Cleanup Event")),
      body: const Center(
        child: Text("Event Form Here", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Event Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              height: 200,
              color: Colors.blueGrey,
              child: const Center(
                child: Text(
                  "Event Banner",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Date: 2025-07-01\nTime: 9:00 AM - 12:00 PM\nPlace: Juhu Beach\nStatus: Ongoing",
              style: TextStyle(color: Colors.white),
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
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Short description of the event goes here.",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            const Text(
              "Stats: 10/20 volunteers, 3 hours planned, 50kg target",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Participate",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share, color: Colors.white),
                  label: const Text(
                    "Share",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.directions, color: Colors.white),
                  label: const Text(
                    "Get Directions",
                    style: TextStyle(color: Colors.white),
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
