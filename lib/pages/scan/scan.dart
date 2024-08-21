import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pola_flutter/analytics/analytics_about_row.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/pages/scan/scan_event.dart';
import 'package:pola_flutter/pages/scan/scan_state.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/pages/scan/scan_vibration.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/ui/menu_bottom_sheet.dart';
import 'package:pola_flutter/ui/web_view_dialog.dart';
import 'companies_list.dart';
import 'scan_bloc.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late ScanBloc _scanBloc;
  MobileScannerController cameraController =
      MobileScannerController(detectionSpeed: DetectionSpeed.normal);
  final PolaAnalytics _analytics = PolaAnalytics.instance();

  ScrollController listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scanBloc = ScanBloc(PolaApiRepository(), ScanVibrationImpl(), _analytics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildQrView(context),
          SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          _analytics.aboutPolaOpened();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return WebViewDialog(
                                url: "https://www.pola-app.pl/m/about",
                                title: t.menu.aboutPola,
                              );
                            },
                          );
                        },
                        icon: Image.asset(
                          "assets/ic_launcher.png",
                          width: 40,
                          height: 40,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Skanowanie",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _analytics.aboutOpened(AnalyticsAboutRow.menu);
                          showModalBottomSheet<void>(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return MenuBottomSheet(analytics: _analytics);
                              });
                        },
                        icon: Assets.menuPage.menu.svg(
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Spacer(),
                BlocBuilder<ScanBloc, ScanState>(
                  bloc: _scanBloc,
                  builder: (context, state) {
                    return CompaniesList(state, listScrollController);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    return Stack(
      children: [
        Positioned.fill(
          child: MobileScanner(
              controller: cameraController,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  final String code = barcode.rawValue!;
                  debugPrint('Barcode found! $code');
                  _scanBloc.add(ScanEvent.barcodeScanned(code));
                }
              }),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: scanArea,
              height: scanArea / 1.25,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(width: 5.0, color: Colors.black),
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}

