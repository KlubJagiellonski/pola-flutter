import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'replacement.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Replacement extends Equatable {
  final String name;
  final String code;
  final String company;
  final String description;
  final String displayName;
  final bool isFriend;

  Replacement(
    {required this.name, 
    required this.code,
    required this.company, 
    required this.description,
    required this.displayName,
    required this.isFriend});

  factory Replacement.fromJson(Map<String, dynamic> json) => _$ReplacementFromJson(json);

  Map<String, dynamic> toJson() => _$ReplacementToJson(this);

  @override
  List<Object?> get props => [name, company, description, displayName, isFriend];
}
