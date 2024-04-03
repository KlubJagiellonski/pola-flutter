// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      name: json['name'] as String?,
      plCapital: json['plCapital'] as int?,
      plCapitalNotes: json['plCapitalNotes'] as String?,
      plWorkers: json['plWorkers'] as int?,
      plWorkersNotes: json['plWorkersNotes'] as String?,
      plRnD: json['plRnD'] as int?,
      plRnDNotes: json['plRnDNotes'] as String?,
      plRegistered: json['plRegistered'] as int?,
      plRegisteredNotes: json['plRegisteredNotes'] as String?,
      plNotGlobEnt: json['plNotGlobEnt'] as int?,
      plNotGlobEntNotes: json['plNotGlobEntNotes'] as String?,
      plScore: json['plScore'] as int?,
      isFriend: json['is_friend'] as bool?,
      friendText: json['friend_text'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'name': instance.name,
      'plCapital': instance.plCapital,
      'plCapitalNotes': instance.plCapitalNotes,
      'plWorkers': instance.plWorkers,
      'plWorkersNotes': instance.plWorkersNotes,
      'plRnD': instance.plRnD,
      'plRnDNotes': instance.plRnDNotes,
      'plRegistered': instance.plRegistered,
      'plRegisteredNotes': instance.plRegisteredNotes,
      'plNotGlobEnt': instance.plNotGlobEnt,
      'plNotGlobEntNotes': instance.plNotGlobEntNotes,
      'plScore': instance.plScore,
      'is_friend': instance.isFriend,
      'friend_text': instance.friendText,
      'description': instance.description,
    };
