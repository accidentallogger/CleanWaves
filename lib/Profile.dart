import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'ConfigColors.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolors.backgroColor,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Center(
          child: const Text(
            "User Profile",
            style: TextStyle(
              color: appcolors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/placeholder.jpg"),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Score: 1500",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Stat Boxes (Minimal style)
            Row(
              children: [
                _buildMiniStatBox(
                  icon: Icons.delete_outline,
                  label: 'Waste',
                  value: '120kg',
                ),
                const SizedBox(width: 12),
                _buildMiniStatBox(
                  icon: Icons.access_time,
                  label: 'Hours',
                  value: '35h',
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Chart
            Text(
              'Hours Volunteered (Events)',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
            SizedBox(
              height: 180,
              child: SfCartesianChart(
                backgroundColor: Colors.transparent,
                primaryXAxis: CategoryAxis(),
                series: <CartesianSeries<dynamic, dynamic>>[
                  ColumnSeries<dynamic, dynamic>(
                    dataSource: [
                      {'event': 'A', 'hours': 5},
                      {'event': 'B', 'hours': 10},
                      {'event': 'C', 'hours': 8},
                      {'event': 'D', 'hours': 12},
                    ],
                    xValueMapper: (data, _) => data['event'],
                    yValueMapper: (data, _) => data['hours'],
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Buttons
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'My Events',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),

                const SizedBox(width: 12),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Organized Events',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                const SizedBox(width: 12),

                ElevatedButton.icon(
                  onPressed: () {
                    _showInsightsDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.insights, color: Colors.white),
                  label: const Text(
                    'AI Insights',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Badges - horizontal scroll
            Text(
              'Badges',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, index) => _buildImagePlaceholder(),
              ),
            ),

            const SizedBox(height: 16),

            // Mascot Skins - horizontal scroll
            Text(
              'Mascot Skins',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, index) => _buildImagePlaceholder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniStatBox({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blueAccent, size: 20),
            const SizedBox(width: 6),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.image, color: Colors.white54),
    );
  }

  void _showInsightsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('AI Insights', style: TextStyle(color: Colors.white)),
        content: const Text(
          'You volunteered 35h and collected 120kg waste. Keep going to unlock more!',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }
}
