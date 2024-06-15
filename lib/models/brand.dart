import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'brand.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Brand extends Equatable {
  final String? name;
  final String? logotypeUrl;

  Brand({required this.name, required this.logotypeUrl});

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);

  @override
  List<Object?> get props => [name, logotypeUrl];
}
