import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pola_flutter/analytics/analytics_about_row.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/pages/scan/scan_vibration.dart';
import 'package:pola_flutter/ui/menu_bottom_sheet.dart';
import 'companies_list.dart';
import 'scan_bloc.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late ScanBloc _scanBloc;
  MobileScannerController cameraController = MobileScannerController(detectionSpeed: DetectionSpeed.normal);
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
        title: Center(
          child: IconButton(
            onPressed: () {
              cameraController.toggleTorch();
            },
            icon: Image.asset("assets/ic_flash_on_white_48dp.png"),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            _analytics.aboutPolaOpened();
            Navigator.pushNamed(context, '/web', arguments: "https://www.pola-app.pl/m/about");
          },
          icon: Image.asset("assets/ic_launcher.png"),
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
            icon: Image.asset("assets/menu.png"),
          )
        ],
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
                  switch (state.runtimeType) {
                    case ScanLoaded:
                      return CompaniesList(state as ScanLoaded, listScrollController);
                    default:
                      return Container();
                  }
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
    var scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 250.0 : 300.0;
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
                  _scanBloc.add(GetCompanyEvent(int.parse(code)));
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
