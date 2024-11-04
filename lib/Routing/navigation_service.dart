import 'package:flutter/widgets.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void navigatePOPOfArgs() {
    return navigatorKey.currentState!.pop(true);
  }

  static void navigatePOPOf() {
    return navigatorKey.currentState!.pop();
  }

  static Future<dynamic> navigatePOP(
      String routeName, Map<String, dynamic> arg) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arg);
  }

  static Future<dynamic> navigatePRN(
      String routeName, Map<String, dynamic> arg) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arg);
  }

  static Future<dynamic> navigatePN(
      String routeName, Map<String, dynamic> arg) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arg);
  }

  static Future<dynamic> navigatePNNoArgs(
    String routeName,
  ) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
    );
  }

  static Future<dynamic> navigateToWithoutPost(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  static Future<dynamic> navigateToVideoPlayer(String routeName, int id) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: id);
  }

  static Future<dynamic> navigatePushToErrorPage(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static Future<dynamic> navigateToCourseVideoPlayer(
      String routeName, Map<String, dynamic> arg) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arg);
  }

  static Future<dynamic> navigateSubscribeNotifier(
      {String? routeName, Map<String, dynamic>? arg}) {
    return navigatorKey.currentState!.pushNamed(routeName!, arguments: arg);
  }

  static Future<dynamic> navigateJustPush({dynamic routeVal}) async {
    return await navigatorKey.currentState!.push(routeVal);
  }
}
