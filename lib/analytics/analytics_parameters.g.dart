// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyticsScanCodeParameters _$AnalyticsScanCodeParametersFromJson(
        Map<String, dynamic> json) =>
    AnalyticsScanCodeParameters(
      code: json['code'] as String,
      source: json['source'] as String,
    );

Map<String, dynamic> _$AnalyticsScanCodeParametersToJson(
        AnalyticsScanCodeParameters instance) =>
    <String, dynamic>{
      'code': instance.code,
      'source': instance.source,
    };

AnalyticsAboutParameters _$AnalyticsAboutParametersFromJson(
        Map<String, dynamic> json) =>
    AnalyticsAboutParameters(
      item: json['item'] as String,
    );

Map<String, dynamic> _$AnalyticsAboutParametersToJson(
        AnalyticsAboutParameters instance) =>
    <String, dynamic>{
      'item': instance.item,
    };

AnalyticsProductResultParameters _$AnalyticsProductResultParametersFromJson(
        Map<String, dynamic> json) =>
    AnalyticsProductResultParameters(
      code: json['code'] as String?,
      company: json['company'] as String?,
      productId: json['product_id'] as String?,
    );

Map<String, dynamic> _$AnalyticsProductResultParametersToJson(
    AnalyticsProductResultParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  writeNotNull('company', instance.company);
  writeNotNull('product_id', instance.productId);
  return val;
}
