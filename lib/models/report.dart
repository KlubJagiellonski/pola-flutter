import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'report.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Report extends Equatable {
  final String? text;
  final String? buttonText;
  final String? buttonType;

  Report(
      {required this.text, required this.buttonText, required this.buttonType});

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);

  @override
  List<Object?> get props => [text, buttonText, buttonType];
}
