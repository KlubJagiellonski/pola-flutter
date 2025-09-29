import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'replacement.g.dart';

@JsonSerializable()
class Replacement extends Equatable {
  final String? code;
  final String? name;
  final String? company;
  final String? description;

  @JsonKey(name: 'display_name')
  final String? displayName;

  Replacement({
    required this.code,
    required this.name,
    required this.company,
    required this.description,
    required this.displayName,
  });

  factory Replacement.fromJson(Map<String, dynamic> json) =>
      _$ReplacementFromJson(json);

  Map<String, dynamic> toJson() => _$ReplacementToJson(this);

  @override
  List<Object?> get props => [code, name, company, description, displayName];
}

