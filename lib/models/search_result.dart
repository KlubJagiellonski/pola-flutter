import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:pola_flutter/models/brand.dart';
import 'package:pola_flutter/models/company.dart';
import 'package:pola_flutter/models/donate.dart';
import 'package:pola_flutter/models/report.dart';
import 'package:pola_flutter/models/replacement.dart';

part 'search_result.g.dart';

@JsonSerializable()
class SearchResult extends Equatable {
  @JsonKey(name: 'product_id')
  final int? productId;
  final String? code;
  final String? name;
  @JsonKey(name: 'card_type')
  final String? cardType;
  final String? altText;
  final List<Company>? companies;
  final Report? report;
  final Donate? donate;
  final List<Replacement>? replacements;

  @JsonKey(name: 'all_company_brands')
  final List<Brand>? allCompanyBrands;

  SearchResult(
      {required this.productId,
      required this.code,
      required this.name,
      required this.cardType,
      this.altText,
      required this.companies,
      required this.report,
      required this.donate,
      this.replacements,
      this.allCompanyBrands
      });

  SearchResult.empty()
      : productId = null,
        code = null,
        name = null,
        cardType = null,
        altText = null,
        companies = null,
        report = null,
        donate = null,
        replacements = null,
        allCompanyBrands = null;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);

  @override
  List<Object?> get props =>
      [productId, code, name, cardType, altText, companies, report, donate, replacements];
}
