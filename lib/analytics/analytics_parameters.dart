import 'package:json_annotation/json_annotation.dart';

part 'analytics_parameters.g.dart';

@JsonSerializable()
class AnalyticsScanCodeParameters {
  final String code;
  final String source;

  AnalyticsScanCodeParameters({required this.code, required this.source});

  Map<String, dynamic> toJson() => _$AnalyticsScanCodeParametersToJson(this);
}
