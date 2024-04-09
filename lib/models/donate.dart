import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'donate.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Donate extends Equatable {
  final bool showButton;
  final String url;
  final String title;

  Donate({required this.showButton, required this.url, required this.title});

  factory Donate.fromJson(Map<String, dynamic> json) => _$DonateFromJson(json);

  Map<String, dynamic> toJson() => _$DonateToJson(this);

  @override
  List<Object?> get props => [showButton, url, title];
}
