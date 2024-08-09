import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:pola_flutter/i18n/strings.g.dart';

class PolishCapitalGraph extends StatelessWidget {
  final double percentage;

  PolishCapitalGraph({required this.percentage});

  @override
  Widget build(BuildContext context) {
    final size = 140.0;
    final thickness = 0.15;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: size,
          width: size,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                axisLineStyle: AxisLineStyle(
                  thickness: thickness,
                  cornerStyle: CornerStyle.bothCurve,
                  color: Color(0xFFF5DEDD),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: percentage,
                    cornerStyle: CornerStyle.bothCurve,
                    width: thickness,
                    sizeUnit: GaugeSizeUnit.factor,
                    color: Color(0xFFE1203E),
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    positionFactor: 0.01,
                    angle: 90,
                    widget: Text(
                      '${percentage.toInt()}%',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.lato,
                         color: Color(0xFF1C1B1F),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Text(
            t.companyScreen.polishCapital,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w400,
               color: Color(0xFF1C1B1F),
              fontFamily: FontFamily.lato,
            ),
          ),
        ),
      ],
    );
  }
}