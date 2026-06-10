import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/config/firebase_config.dart';
import 'package:pola_flutter/data/device_id_service.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/pola_tab_controller.dart';
import 'package:pola_flutter/firebase_options.dart';
import 'package:pola_flutter/pages/scan/scan_vibration.dart';
import 'package:pola_flutter/ui/flavor_banner.dart';
import 'package:logging/logging.dart' as logging;

const _appFlavor = String.fromEnvironment(
  'FLUTTER_APP_FLAVOR',
  defaultValue: 'prod',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    _setupLogging();
  }
  if (isFirebaseEnabled) {
    await Firebase.initializeApp(
      name: "Pola",
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  final deviceIdService = await DeviceIdService.create();
  runApp(
    PolaApp(
      polaApi: PolaApiRepository(deviceIdService: deviceIdService),
      analytics: PolaAnalytics.instance(),
      scanVibration: ScanVibrationImpl(),
    ),
  );
}

class PolaApp extends StatelessWidget {
  final PolaApi polaApi;
  final PolaAnalytics analytics;
  final ScanVibration scanVibration;

  const PolaApp({
    super.key,
    required this.polaApi,
    required this.analytics,
    required this.scanVibration,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PolaApi>.value(value: polaApi),
        RepositoryProvider<PolaAnalytics>.value(value: analytics),
        RepositoryProvider<ScanVibration>.value(value: scanVibration),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.light().copyWith(primary: Colors.red),
          ),
          home: FlavorBanner(flavor: _appFlavor, child: PolaTabController()),
        ),
      ),
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint(transition.toString());
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint(error.toString());
    super.onError(bloc, error, stackTrace);
  }
}

void _setupLogging() {
  Bloc.observer = SimpleBlocObserver();
  logging.Logger.root.level = logging.Level.ALL;
  logging.Logger.root.onRecord.listen((rec) {
    debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
