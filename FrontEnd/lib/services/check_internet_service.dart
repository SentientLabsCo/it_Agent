// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class InternetCheckService {


  /// Check if the device is connected to WiFi or Ethernet
  Future<bool> checkDeviceConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    for (final result in connectivityResult) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet) {
        return true;
      }
    }
    print("No active connections found");
    return false;
  }

  /// Check if the internet is actually accessible (ping google)
  Future<bool> pingSite() async {
    try {
      final response = await http
          .get(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 10));
      print("Ping response: ${response.statusCode}");
      return response.statusCode == 200;
    } catch (e) {
      print("Ping failed: $e");
      return false;
    }
  }

  /// Full flow: check local connection and internet accessibility
  Future<(bool deviceConnected, bool internetAccessible)>
  checkInternetStatus() async {
    final deviceConnected = await checkDeviceConnection();
    final internetAccessible = deviceConnected ? await pingSite() : false;
    return (deviceConnected, internetAccessible);
  }

  Future<bool> checkDeviceConnectionWithDelay() async{
    await Future.delayed(const Duration(seconds: 3));
    return await checkDeviceConnection();
  }

  Future<bool> pingSiteWithDelay() async{
    await Future.delayed(const Duration(seconds: 5));
    return await pingSite();
  }
}
