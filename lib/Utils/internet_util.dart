import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/app_config_constants.dart';
import 'package:hp_finance/Network/api_urls.dart';
import 'package:hp_finance/Network/network.dart';

class InternetUtil with ChangeNotifier {
  static final InternetUtil _internetUtil = InternetUtil._internal();

  factory InternetUtil() {
    return _internetUtil;
  }

  InternetUtil._internal();
  bool isInternetConnected = true;

  Future<void> initConnectivity() async {
    StreamSubscription<List<ConnectivityResult>> subscription = Connectivity().onConnectivityChanged
        .listen((List<ConnectivityResult> connectivityResult) {
      if (connectivityResult.contains(ConnectivityResult.mobile)) {
        AppConfigConstants.connectivityType = "Mobile";
      } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
        AppConfigConstants.connectivityType = "WiFi";
      } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
        AppConfigConstants.connectivityType = "VPN";
      } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
        AppConfigConstants.connectivityType = "Ethernet";
      } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
        AppConfigConstants.connectivityType = "Bluetooth";
      } else if (connectivityResult.contains(ConnectivityResult.other)) {
        AppConfigConstants.connectivityType = "Other";
      } else {
        AppConfigConstants.connectivityType = "None";
      }
    });
  }

  Future<bool> checkInternetConnection() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      bool hasData =
          await Network().checkNetworkConnection(2, APIURLs.networkCheckURL);
      if (hasData) {
        isInternetConnected = true;
        return true;
      } else {
        isInternetConnected = false;
        return false;
      }
    } else {
      isInternetConnected = true;
      return true;
    }
  }

  Future<String> getConnectivityName() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    String connectedValue = "None";
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      connectedValue = "Mobile";
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      connectedValue = "WiFi";
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      connectedValue = "VPN";
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      connectedValue = "Ethernet";
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      connectedValue = "Bluetooth";
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      connectedValue = "Other";
    }

    return connectedValue;
  }
}
