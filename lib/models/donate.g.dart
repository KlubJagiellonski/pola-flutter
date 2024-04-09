// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Donate _$DonateFromJson(Map<String, dynamic> json) => Donate(
      showButton: json['show_button'] as bool,
      url: json['url'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$DonateToJson(Donate instance) => <String, dynamic>{
      'show_button': instance.showButton,
      'url': instance.url,
      'title': instance.title,
    };
