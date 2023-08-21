import 'package:json_annotation/json_annotation.dart';

part 'analytics_parameters.g.dart';

@JsonSerializable(createFactory: false)
class AnalyticsScanCodeParameters {
  final String code;
  final String source;

  AnalyticsScanCodeParameters({required this.code, required this.source});

  Map<String, dynamic> toJson() => _$AnalyticsScanCodeParametersToJson(this);
}

@JsonSerializable(createFactory: false)
class AnalyticsAboutParameters {
  final String item;

  AnalyticsAboutParameters({required this.item});

  Map<String, dynamic> toJson() => _$AnalyticsAboutParametersToJson(this);
}

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake, includeIfNull: false)
class AnalyticsProductResultParameters {
  final String? code;
  final String? company;
  final String? productId;

  AnalyticsProductResultParameters(
      {required this.code, this.company, this.productId});

  Map<String, dynamic> toJson() => _$AnalyticsProductResultParametersToJson(this);
}

@JsonSerializable(createFactory: false)
class AnalyticsMainTabParameters {
  final String tab;

  AnalyticsMainTabParameters({required this.tab});

  Map<String, dynamic> toJson() => _$AnalyticsMainTabParametersToJson(this);
}
