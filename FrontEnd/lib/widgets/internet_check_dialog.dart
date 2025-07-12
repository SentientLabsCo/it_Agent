/*
This widget displays a dialog that checks if the device is connected to the internet
and if it can access a specific website.
Written by: [Arpit Raghuvanshi]
Date: [July 6 2025]
 */

import 'package:flutter/material.dart';
import 'package:it_agent/services/check_internet_service.dart';

class InternetSpeedDialog extends StatefulWidget {
  const InternetSpeedDialog({super.key});

  @override
  State<InternetSpeedDialog> createState() => _InternetSpeedDialogState();
}

class _InternetSpeedDialogState extends State<InternetSpeedDialog> {
  bool? isDeviceConnected;
  bool? isInternetAccessible;
  bool isDone = false;
  bool isStep1Running = false;
  bool isStep2Running = false;

  final InternetCheckService _internetService = InternetCheckService();

  @override
  void initState() {
    super.initState();
    _checkInternetStepsSequentially();
  }

  Future<void> _checkInternetStepsSequentially() async {
    setState(() {
      isDeviceConnected = null;
      isInternetAccessible = null;
      isDone = true;
      isStep1Running = true;
      isStep2Running = false;
    });

    final deviceConnected = await _internetService
        .checkDeviceConnectionWithDelay();

    setState(() {
      isDeviceConnected = deviceConnected;
      isStep1Running = false;
    });

    if (deviceConnected) {
      setState(() {
        isStep2Running = true;
      });

      final internetAccessible = await _internetService.pingSiteWithDelay();

      setState(() {
        isInternetAccessible = internetAccessible;
        isStep2Running = false;
        isDone = true;
      });
    } else {
      setState(() {
        isInternetAccessible = false;
        isDone = true;
      });
    }
  }

  Widget _buildStatusRow(String title, bool? status, bool isRunning) {
    Widget icon;
    if (isRunning) {
      // Show animated loading indicator when step is running
      icon = const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      );
    } else if (status == null) {
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
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isRunning ? Colors.blue : Colors.black,
            ),
          ),
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
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildStatusRow(
                "1. Checking device connection...",
                isDeviceConnected,
                isStep1Running,
              ),
              const SizedBox(height: 16),
              _buildStatusRow(
                "2. Pinging www.google.com...",
                isInternetAccessible,
                isStep2Running,
              ),
              const SizedBox(height: 24),
              if (isStep1Running || isStep2Running)
                Center(
                  child: Text(
                    'Please wait...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                )
              else if (isDone)
                Center(
                  child: Text(
                    (isDeviceConnected == true && isInternetAccessible == true)
                        ? '✅ Internet connectivity is fine.'
                        : '❌ Internet issue detected.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          (isDeviceConnected == true &&
                              isInternetAccessible == true)
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
              if (isDone) ...[
                const SizedBox(height: 16),
                TextButton.icon(
                  onPressed: (isStep1Running || isStep2Running)
                      ? null
                      : () {
                          _checkInternetStepsSequentially();
                        },
                  icon: const Icon(Icons.refresh),
                  label: const Text("Retry"),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
