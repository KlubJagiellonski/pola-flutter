import 'package:json_annotation/json_annotation.dart';

part 'analytics_parameters.g.dart';

@JsonSerializable()
class AnalyticsScanCodeParameters {
  final String code;
  final String source;

  AnalyticsScanCodeParameters({required this.code, required this.source});

  Map<String, dynamic> toJson() => _$AnalyticsScanCodeParametersToJson(this);
}

@JsonSerializable()
class AnalyticsAboutParameters {
  final String item;

  AnalyticsAboutParameters({required this.item});

  Map<String, dynamic> toJson() => _$AnalyticsAboutParametersToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class AnalyticsProductResultParameters {
  final String? code;
  final String? company;
  final String? productId;

  AnalyticsProductResultParameters(
      {required this.code, this.company, this.productId});

  Map<String, dynamic> toJson() => _$AnalyticsProductResultParametersToJson(this);
}
