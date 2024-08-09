// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
      productId: (json['product_id'] as num?)?.toInt(),
      code: json['code'] as String?,
      name: json['name'] as String?,
      cardType: json['card_type'] as String?,
      altText: json['altText'] as String?,
      companies: (json['companies'] as List<dynamic>?)
          ?.map((e) => Company.fromJson(e as Map<String, dynamic>))
          .toList(),
      report: json['report'] == null
          ? null
          : Report.fromJson(json['report'] as Map<String, dynamic>),
      donate: json['donate'] == null
          ? null
          : Donate.fromJson(json['donate'] as Map<String, dynamic>),
      allCompanyBrands: (json['all_company_brands'] as List<dynamic>?)
          ?.map((e) => Brand.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'code': instance.code,
      'name': instance.name,
      'card_type': instance.cardType,
      'altText': instance.altText,
      'companies': instance.companies,
      'report': instance.report,
      'donate': instance.donate,
      'all_company_brands': instance.allCompanyBrands,
    };
