import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'alternative.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Alternative extends Equatable {
  final String name;
  final String company;
  final String description;
  final String displayName;
  final bool isFriend;

  Alternative({required this.name, required this.company, required this.description, required this.displayName, required this.isFriend});

  factory Alternative.fromJson(Map<String, dynamic> json) => _$AlternativeFromJson(json);

  Map<String, dynamic> toJson() => _$AlternativeToJson(this);

  @override
  List<Object?> get props => [name, company, description, displayName, isFriend];
}
