import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'ConfigColors.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  double _circleRadius = 100;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  DateTime? _pickedDate;
  TimeOfDay? _pickedTime;

  LatLng? _currentLocation;
  final List<LatLng> _polygonPoints = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location services are disabled.")),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission denied.")),
        );
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text("Add Cleanup Event"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(_titleController, "Event Title"),
                  const SizedBox(height: 10),
                  _buildTextField(_descController, "Description", maxLines: 3),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent.withOpacity(0.8),
                        ),
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (date != null) setState(() => _pickedDate = date);
                        },
                        child: const Text(
                          "Pick Date",
                          style: TextStyle(color: appcolors.textColor),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appcolors.buttonColor.withOpacity(
                            0.8,
                          ),
                        ),
                        onPressed: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) setState(() => _pickedTime = time);
                        },
                        child: const Text(
                          "Pick Time",
                          style: TextStyle(color: appcolors.textColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white38),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter:
                          _currentLocation ?? LatLng(19.1048, 72.8247),
                      initialZoom: 14,
                      onTap: (tapPos, latLng) {
                        setState(() {
                          _currentLocation = latLng;
                        });
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      if (_currentLocation != null)
                        CircleLayer(
                          circles: [
                            CircleMarker(
                              point: _currentLocation!,
                              color: Colors.blue.withOpacity(0.7),
                              borderColor: Colors.blueAccent,
                              borderStrokeWidth: 2,
                              radius: _circleRadius,
                              useRadiusInMeter: true,
                            ),
                          ],
                        ),
                      if (_currentLocation != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: _currentLocation!,
                              width: 40,
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.blue,
                                size: 40,
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
                  child: Column(
                    children: [
                      FloatingActionButton(
                        mini: true,
                        heroTag: "clear_circle",
                        backgroundColor: Colors.redAccent,
                        onPressed: () {
                          setState(() {
                            _currentLocation = null;
                          });
                        },
                        child: const Icon(Icons.clear, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (_currentLocation != null)
              Column(
                children: [
                  const Text(
                    "Adjust Radius (meters)",
                    style: TextStyle(color: Colors.white),
                  ),
                  Slider(
                    value: _circleRadius,
                    min: 50,
                    max: 1000,
                    divisions: 19,
                    label: _circleRadius.toStringAsFixed(0),
                    onChanged: (value) {
                      setState(() {
                        _circleRadius = value;
                      });
                    },
                  ),
                  Text(
                    "Lat: ${_currentLocation!.latitude.toStringAsFixed(6)}, "
                    "Lng: ${_currentLocation!.longitude.toStringAsFixed(6)}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Radius: ${_circleRadius.toStringAsFixed(0)} meters",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: appcolors.buttonColor.withOpacity(0.8),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (_polygonPoints.length < 3) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please mark an area on the map"),
                      ),
                    );
                    return;
                  }
                  // Submit logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Event Submitted!")),
                  );
                }
              },
              child: const Text(
                "Submit Event",
                style: TextStyle(color: appcolors.textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      maxLines: maxLines,
      validator: (value) =>
          value == null || value.isEmpty ? "Please enter $hint" : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: Colors.grey[850],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class FullMapScreen extends StatefulWidget {
  final List<LatLng> points;
  const FullMapScreen({super.key, required this.points});

  @override
  State<FullMapScreen> createState() => _FullMapScreenState();
}

class _FullMapScreenState extends State<FullMapScreen> {
  final List<LatLng> _polygonPoints = [];

  @override
  void initState() {
    super.initState();
    _polygonPoints.addAll(widget.points);
  }

  void _handleMapTap(LatLng latLng) {
    if (_polygonPoints.isNotEmpty) {
      final first = _polygonPoints.first;
      final dist = Distance().as(LengthUnit.Meter, first, latLng);
      if (dist < 10 && _polygonPoints.length > 2) {
        // Close the polygon
        setState(() {
          _polygonPoints.add(first);
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Area closed.")));
        return;
      }
    }

    setState(() {
      _polygonPoints.add(latLng);
    });
  }

  void _clearPolygon() {
    setState(() {
      _polygonPoints.clear();
    });
  }

  void _savePolygon() {
    if (_polygonPoints.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please mark at least 3 points.")),
      );
      return;
    }
    debugPrint("Saved Points:");
    for (var point in _polygonPoints) {
      debugPrint("${point.latitude}, ${point.longitude}");
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Region saved! Check console.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text("Select Area"),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: _polygonPoints.isNotEmpty
                  ? _polygonPoints.first
                  : LatLng(19.1048, 72.8247),
              initialZoom: 14,
              onTap: (tapPos, latLng) => _handleMapTap(latLng),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              if (_polygonPoints.isNotEmpty)
                PolygonLayer(
                  polygons: [
                    Polygon(
                      points: _polygonPoints,
                      color: Colors.blueAccent.withOpacity(0.3),
                      borderColor: Colors.blueAccent,
                      borderStrokeWidth: 3,
                    ),
                  ],
                ),
              MarkerLayer(
                markers: _polygonPoints
                    .map(
                      (point) => Marker(
                        point: point,
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                          size: 40,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Column(
              children: [
                FloatingActionButton(
                  mini: true,
                  heroTag: "save_polygon",
                  backgroundColor: Colors.green,
                  onPressed: _savePolygon,
                  child: const Icon(Icons.save, color: Colors.white),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  mini: true,
                  heroTag: "clear_polygon",
                  backgroundColor: Colors.redAccent,
                  onPressed: _clearPolygon,
                  child: const Icon(Icons.clear, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
