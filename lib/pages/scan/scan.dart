import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/pages/scan/companies_list.dart';
import 'package:pola_flutter/pages/scan/remote_button.dart';
import 'package:pola_flutter/pages/scan/scan_background.dart';
import 'package:pola_flutter/pages/scan/scan_bloc.dart';
import 'package:pola_flutter/pages/scan/scan_event.dart';
import 'package:pola_flutter/pages/scan/scan_search_button.dart';
import 'package:pola_flutter/pages/scan/scan_state.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/pages/scan/scan_vibration.dart';
import 'package:pola_flutter/pages/scan/torch_button.dart';
import 'package:pola_flutter/pages/scan/reset_button.dart';
import 'package:pola_flutter/pages/scan/torch_controller.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/text_size.dart';
import 'package:pola_flutter/ui/menu_icon_button.dart';
import 'package:pola_flutter/ui/web_view_dialog.dart';

class MainPage extends StatefulWidget {
  final RouteObserver<ModalRoute<dynamic>> routeObserver;
  final ValueNotifier<bool> scanTabActive;

  const MainPage({required this.routeObserver, required this.scanTabActive});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with RouteAware {
  late ScanBloc _scanBloc;
  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    formats: [BarcodeFormat.ean13, BarcodeFormat.ean8],
  );
  final PolaAnalytics _analytics = PolaAnalytics.instance();
  bool _childRoutePushed = false;

  ScrollController listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scanBloc = ScanBloc(PolaApiRepository(), ScanVibrationImpl(), _analytics,
        TorchControllerImpl(cameraController: cameraController));
    widget.scanTabActive.addListener(_onScanTabActiveChanged);
  }

  void _onScanTabActiveChanged() {
    if (widget.scanTabActive.value) {
      if (!_childRoutePushed) {
        cameraController.start();
      }
    } else {
      cameraController.stop();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null) {
      widget.routeObserver.subscribe(this, route);
    }
  }

  @override
  void didPushNext() {
    _childRoutePushed = true;
    cameraController.stop();
  }

  @override
  void didPopNext() {
    _childRoutePushed = false;
    if (widget.scanTabActive.value) {
      cameraController.start();
    }
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
            showWebViewDialog(
                context: context,
                url: "https://www.pola-app.pl/m/about",
                title: t.menu.aboutPola);
          },
          icon: Assets.icLauncher.image(),
        ),
        actions: [MenuIconButton(color: AppColors.white)],
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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  ScanSearchButton(analytics: _analytics),
                ],
              ),
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
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(t.scan.error),
                              content: Text(t.scan.tryAgain),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(t.scan.closeError),
                                  onPressed: () {
                                    _scanBloc
                                        .add(ScanEvent.alertDialogDismissed());
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                    }

                    return Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                              child: CompaniesList(state, listScrollController,
                                  () {
                            _scanBloc.add(ScanEvent.closeRemoteButton());
                          })),
                          Column(
                            children: [
                              if (state.list.isNotEmpty)
                                ResetButton(
                                  onTap: () {
                                    _scanBloc
                                        .add(ScanEvent.resetScannedCompaniesButton());
                                  },
                                ),
                              TorchButton(
                                isTorchOn: state.isTorchOn,
                                onTap: () {
                                  _scanBloc.add(ScanEvent.torchSwitched());
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      if (state.remoteButtonState != null)
                        RemoteButton(state.remoteButtonState!, () {
                          _scanBloc.add(ScanEvent.closeRemoteButton());
                        })
                    ]);
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
            },
          ),
        ),
        ScanBackground(),
      ],
    );
  }

  @override
  void dispose() {
    widget.scanTabActive.removeListener(_onScanTabActiveChanged);
    widget.routeObserver.unsubscribe(this);
    cameraController.dispose();
    super.dispose();
  }
}
