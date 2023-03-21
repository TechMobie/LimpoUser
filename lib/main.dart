import 'dart:async';

import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:linpo_user/app/data/controllers/global_controller.dart';

import 'app/routes/app_pages.dart';
import 'helper/utils/common_functions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';


Future<void> main() async {
  await GetStorage.init();
  final GlobalController globalController =
      Get.put<GlobalController>(GlobalController());
  final facebookAppEvents = FacebookAppEvents();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  final status = await AppTrackingTransparency.requestTrackingAuthorization();

  facebookAppEvents.setAdvertiserTracking(enabled: true);

  // FacebookSdk.isAdvertiserIDCollectionEnabled(true);
  // FacebookSdk.addLoggingBehavior(LoggingBehavior.REQUESTS);
  // FacebookSdk.addLoggingBehavior(LoggingBehavior.INCLUDE_RAW_RESPONSES);
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    if (!kDebugMode) {
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
    }
    runApp(const MyApp());
  }, (error, stack) {
    if (!kDebugMode) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale("en", ""),
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('es', ''), // Spanish, no country code
      ],
      //home: VerifyEmailScreen(),
      navigatorKey: key,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialRoute: Routes.initial,
      theme: ThemeData(fontFamily: "SF-UI"),
    );
  }
}
