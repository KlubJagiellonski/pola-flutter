import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_search_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductSearchResponse extends Equatable {
  final String? nextPageToken;
  final List<ProductSearchItem> products;
  final int totalItems;

  const ProductSearchResponse({
    required this.nextPageToken,
    required this.products,
    required this.totalItems,
  });

  factory ProductSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSearchResponseToJson(this);

  @override
  List<Object?> get props => [nextPageToken, products, totalItems];
}

@JsonSerializable(explicitToJson: true)
class ProductSearchItem extends Equatable {
  final String name;
  final String code;
  final ProductSearchCompany? company;
  final ProductSearchBrand? brand;

  const ProductSearchItem({
    required this.name,
    required this.code,
    this.company,
    this.brand,
  });

  factory ProductSearchItem.fromJson(Map<String, dynamic> json) =>
      _$ProductSearchItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSearchItemToJson(this);

  String get subtitle {
    final companyName = company?.name;
    if (companyName != null && companyName.isNotEmpty) {
      return companyName;
    }

    final brandName = brand?.name;
    if (brandName != null && brandName.isNotEmpty) {
      return brandName;
    }

    return code;
  }

  int? get score => company?.score;

  @override
  List<Object?> get props => [name, code, company, brand];
}

@JsonSerializable()
class ProductSearchCompany extends Equatable {
  final String name;
  final int? score;

  const ProductSearchCompany({required this.name, required this.score});

  factory ProductSearchCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductSearchCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSearchCompanyToJson(this);

  @override
  List<Object?> get props => [name, score];
}

@JsonSerializable()
class ProductSearchBrand extends Equatable {
  final String name;

  const ProductSearchBrand({required this.name});

  factory ProductSearchBrand.fromJson(Map<String, dynamic> json) =>
      _$ProductSearchBrandFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSearchBrandToJson(this);

  @override
  List<Object?> get props => [name];
}
