// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      text: json['text'] as String?,
      buttonText: json['button_text'] as String?,
      buttonType: json['button_type'] as String?,
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'text': instance.text,
      'button_text': instance.buttonText,
      'button_type': instance.buttonType,
    };
