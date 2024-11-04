import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hp_finance/AppTheme/app_theme.dart';
import 'package:hp_finance/Constants/app_config_constants.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Constants/string_constants.dart';
import 'package:hp_finance/Routing/navigation_service.dart';
import 'package:hp_finance/Routing/routing.dart';
import 'package:hp_finance/Screens/IntroScreen/intro_screen.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/get_device_info.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:splash_view/source/presentation/pages/splash_view.dart';
import 'package:splash_view/source/presentation/widgets/done.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /* Orientation setup */
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /* Internet Connectivity */
  InternetUtil().initConnectivity();

  /* Device Info */
  GetDeviceInfo().updateDeviceInfo();

  runApp(
    MultiProvider(
      providers: [
        /* App Theme - Dark/Light mode */
        ChangeNotifierProvider<AppTheme>(
          create: (_) => AppTheme(),
        ),
        /* Internet */
        ChangeNotifierProvider<InternetUtil>(
          create: (_) => InternetUtil(),
        ),

        /* App Language Util */
        ChangeNotifierProvider<AppLanguageUtil>(
          create: (_) => AppLanguageUtil(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  Widget splashScreenRouteView = SplashView(
    done: Done(
      const IntroScreen(),
      animationDuration: const Duration(milliseconds: 0),
      curve: Curves.easeInOut,
    ),
    duration: const Duration(seconds: 3),
    logo: Image.asset(
      ImageConstants.launchImage,
    ),
    title: Text(
      StringConstants.launchTitle,
      style: const TextStyle(
        fontWeight: FontWeight.w800,
        color: ColorConstants.whiteColor,
        fontSize: 24.0,
      ),
    ),
    backgroundColor: ColorConstants.darkBlueColor,
    showStatusBar: true,
    subtitle: Text(
      StringConstants.launchSubTitle,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorConstants.whiteColor,
        fontSize: 16.0,
      ),
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<AppTheme>(context);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return AppBuilder(
          builder: (BuildContext context) {
            return MaterialApp(
              title: AppConfigConstants.appName,
              theme: themeNotifier.themeBasic,
              initialRoute: RoutingConstants.routeDefault,
              onGenerateRoute: RouteGenerator.generateRoute,
              navigatorKey: NavigationService.navigatorKey,
              navigatorObservers: const [],
              debugShowCheckedModeBanner:
                  AppConfigConstants.buildCategory == 1 ? true : false,
              home: splashScreenRouteView,
              //showSemanticsDebugger: true,
              builder: (context, widget) {
                MediaQueryData mediaQueryData = MediaQuery.of(context);
                AppConfigConstants.smallestDimension =
                    mediaQueryData.size.height;
                AppConfigConstants.deviceType =
                    (deviceType == DeviceType.mobile) ? 1 : 2;
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    boldText: false,
                    textScaler: const TextScaler.linear(1.0),
                  ),
                  child: widget!,
                );
              },
            );
          },
        );
      },
    );
  }
}

// App Builder
class AppBuilder extends StatefulWidget {
  const AppBuilder({super.key, required this.builder});
  final Function(BuildContext) builder;

  @override
  AppBuilderState createState() => AppBuilderState();

  static AppBuilderState? of(BuildContext context) {
    return context.findAncestorStateOfType<AppBuilderState>();
  }
}

class AppBuilderState extends State<AppBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }

  void rebuild() {
    setState(() {});
  }
}
