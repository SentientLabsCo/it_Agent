// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class InternetSpeedDialog extends StatefulWidget {
  const InternetSpeedDialog({super.key});

  @override
  State<InternetSpeedDialog> createState() => _InternetSpeedDialogState();
}

class _InternetSpeedDialogState extends State<InternetSpeedDialog> {
  bool? isDeviceConnected;
  bool? isInternetAccessible;
  bool isDone = false;

  @override
  void initState() {
    super.initState();
    _checkInternetSteps();
  }

  Future<void> _checkInternetSteps() async {
    final deviceConnected = await _checkDeviceConnection();
    final internet = deviceConnected ? await _pingGoogle() : false;

    setState(() {
      isDeviceConnected = deviceConnected;
      isInternetAccessible = internet;
      isDone = true;
    });
  }

Future<bool> _checkDeviceConnection() async {
  final connectivityResults = await Connectivity().checkConnectivity();
  
  // Check if any of the connection types indicate active connectivity
  for (final result in connectivityResults) {
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet) {
      print("Active connection found: $result");
      return true;
    }
  }
  print("No active connections found");
  return false;
}

  Future<bool> _pingGoogle() async {
    try {
      final response = await http
          .get(Uri.parse('https://www.google.com'))
          .timeout(Duration(seconds: 10));
      print("Ping response: ${response.statusCode}");
      return response.statusCode == 200;
    } catch (e) {
      print("Ping failed: $e");
      return false;
    }
  }

  Widget _buildStatusRow(String title, bool? status) {
    Icon icon;
    if (status == null) {
      icon = const Icon(Icons.hourglass_top, color: Colors.orange);
    } else if (status) {
      icon = const Icon(Icons.check_circle, color: Colors.green);
    } else {
      icon = const Icon(Icons.cancel, color: Colors.red);
    }

    return Row(
      children: [
        icon,
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: SizedBox(
        width: 400,
        height: 340,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Internet Diagnosis',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
              const SizedBox(height: 24),
              _buildStatusRow("1. Checking device connection...", isDeviceConnected),
              const SizedBox(height: 16),
              _buildStatusRow("2. Pinging www.google.com...", isInternetAccessible),
              const SizedBox(height: 24),
              if (isDone)
                Center(
                  child: Text(
                    (isDeviceConnected == true && isInternetAccessible == true)
                        ? '✅ Internet connectivity is fine.'
                        : '❌ Internet issue detected.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: (isDeviceConnected == true && isInternetAccessible == true)
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
              if (isDone) ...[
                const SizedBox(height: 16),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      isDeviceConnected = null;
                      isInternetAccessible = null;
                      isDone = false;
                    });
                    _checkInternetSteps();
                  },
                  icon: Icon(Icons.refresh),
                  label: Text("Retry"),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
