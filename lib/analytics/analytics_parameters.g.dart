// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$AnalyticsScanCodeParametersToJson(
        AnalyticsScanCodeParameters instance) =>
    <String, dynamic>{
      'code': instance.code,
      'source': instance.source,
    };

Map<String, dynamic> _$AnalyticsAboutParametersToJson(
        AnalyticsAboutParameters instance) =>
    <String, dynamic>{
      'item': instance.item,
    };

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

Map<String, dynamic> _$AnalyticsMainTabParametersToJson(
        AnalyticsMainTabParameters instance) =>
    <String, dynamic>{
      'tab': instance.tab,
    };
