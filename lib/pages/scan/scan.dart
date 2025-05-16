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
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late ScanBloc _scanBloc;
  MobileScannerController cameraController =
      MobileScannerController(detectionSpeed: DetectionSpeed.normal);
  final PolaAnalytics _analytics = PolaAnalytics.instance();
  ScrollController listScrollController = ScrollController();

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _scanBloc = ScanBloc(
      PolaApiRepository(),
      ScanVibrationImpl(),
      _analytics,
      TorchControllerImpl(cameraController: cameraController),
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    cameraController.dispose();
    super.dispose();
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
              title: t.menu.aboutPola,
            );
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

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: CompaniesList(
                                state,
                                listScrollController,
                                () {
                                  _scanBloc.add(ScanEvent.closeRemoteButton());
                                },
                              ),
                            ),
                            Column(
                              children: [
                                if (state.list.isNotEmpty)
                                  ResetButton(
                                    onTap: () {
                                      _scanBloc.add(ScanEvent
                                          .resetScannedCompaniesButton());
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
                          }),
                      ],
                    );
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
    final scanAreaSize = 250.0;
    final scanAreaTop =
        MediaQuery.of(context).size.height / 2 - scanAreaSize / 2;

    final laserTopLimit = scanAreaTop + 16;
    final laserBottomLimit = scanAreaTop + scanAreaSize - 85;

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
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final laserTop = laserTopLimit +
                _animation.value * (laserBottomLimit - laserTopLimit);
            return Positioned(
              top: laserTop,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 250,
                  height: 2,
                  color: AppColors.defaultRed,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
