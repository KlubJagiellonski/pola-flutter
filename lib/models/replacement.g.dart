// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replacement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Replacement _$ReplacementFromJson(Map<String, dynamic> json) => Replacement(
      code: json['code'] as String?,
      name: json['name'] as String?,
      company: json['company'] as String?,
      description: json['description'] as String?,
      displayName: json['display_name'] as String?,
    );

Map<String, dynamic> _$ReplacementToJson(Replacement instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'company': instance.company,
      'description': instance.description,
      'display_name': instance.displayName,
    };

