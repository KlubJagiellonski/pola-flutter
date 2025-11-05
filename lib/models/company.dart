import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:pola_flutter/models/brand.dart';

part 'company.g.dart';

@JsonSerializable()
class Company extends Equatable {
  final String? name;
  final int? plCapital;
  final String? plCapitalNotes;
  final int? plWorkers;
  final String? plWorkersNotes;
  final int? plRnD;
  final String? plRnDNotes;
  final int? plRegistered;
  final String? plRegisteredNotes;
  final int? plNotGlobEnt;
  final String? plNotGlobEntNotes;
  final int? plScore;

  @JsonKey(name: 'is_friend')
  final bool? isFriend;

  @JsonKey(name: 'friend_text')
  final String? friendText;
  final String? description;

  @JsonKey(name: 'logotype_url')
  final String? logotypeUrl;

  @JsonKey(name: 'official_url')
  final String? officialUrl;

  final List<Brand> brands;

  Company(
      {required this.name,
      required this.plCapital,
      required this.plCapitalNotes,
      required this.plWorkers,
      required this.plWorkersNotes,
      required this.plRnD,
      required this.plRnDNotes,
      required this.plRegistered,
      required this.plRegisteredNotes,
      required this.plNotGlobEnt,
      required this.plNotGlobEntNotes,
      required this.plScore,
      required this.isFriend,
      required this.friendText,
      required this.description,
      required this.logotypeUrl,
      required this.officialUrl,
      required this.brands});

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
  @override
  List<Object?> get props => [
        name,
        plCapital,
        plCapitalNotes,
        plWorkers,
        plWorkersNotes,
        plRnD,
        plRnDNotes,
        plRegistered,
        plRegisteredNotes,
        plNotGlobEnt,
        plNotGlobEntNotes,
        plScore,
        isFriend,
        friendText,
        description,
        logotypeUrl,
        officialUrl
      ];

  int? getScore() {
    return plScore;
  }
}
