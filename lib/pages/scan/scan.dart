import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pola_flutter/analytics/analytics_about_row.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/pages/scan/scan_event.dart';
import 'package:pola_flutter/pages/scan/scan_state.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/pages/scan/scan_vibration.dart';
import 'package:pola_flutter/pages/menu/menu_bottom_sheet.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/text_size.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
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
          icon: Assets.icLauncher.image(),
        ),
        actions: [
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
            icon: Assets.menuPage.menu.svg(),
          ),
        ],
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            t.scan.scanning,
            style: TextStyle(
              fontSize: TextSize.newsTitle,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          _buildQrView(context),
          SafeArea(
            child: Column(
              children: <Widget>[
                Center(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                            "Umieść kod kreskowy produktu w prostokącie powyżej aby dowiedzieć się więcej o firmie, która go wyprodukowała.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            )))),
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
                  if (state.isError) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return AlertDialog(
                            title: Text('Wystąpił błąd'),
                            content: Text('Niestety nie udało się pobrać danych. Spróbuj ponownie.'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Zamknij.'),
                                onPressed: () {
                                  _scanBloc.add(ScanEvent.alertDialogDismissed());
                                  SchedulerBinding.instance.addPostFrameCallback((_) {
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      );
                    });                  
                  }
                  return CompaniesList(state, listScrollController);
                },
              ),
            ],
          )),
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
