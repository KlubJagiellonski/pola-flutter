import 'package:equatable/equatable.dart';
import 'package:pola_flutter/models/company.dart';
import 'package:pola_flutter/models/donate.dart';
import 'package:pola_flutter/models/report.dart';

class SearchResult extends Equatable {
  int? productId;
  String? code;
  String? name;
  String? cardType;
  String? altText;
  List<Company>? companies;
  Report? report;
  Donate? donate;

  SearchResult(
      {required this.productId,
      required this.code,
      required this.name,
      required this.cardType,
      this.altText,
      required this.companies,
      required this.report,
      required this.donate});

  SearchResult.empty();

  SearchResult.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    code = json['code'];
    name = json['name'];
    cardType = json['card_type'];
    altText = json['altText'];
    if (json['companies'] != null) {
      companies = <Company>[];
      json['companies'].forEach((v) {
        companies!.add(new Company.fromJson(v));
      });
      companies = companies!.toList();
    }
    report =
        (json['report'] != null ? new Report.fromJson(json['report']) : null)!;
    donate =
        (json['donate'] != null ? new Donate.fromJson(json['donate']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['code'] = this.code;
    data['name'] = this.name;
    data['card_type'] = this.cardType;
    data['altText'] = this.altText;
    if (this.companies != null) {
      data['companies'] = this.companies!.map((v) => v.toJson()).toList();
    }
    if (this.report != null) {
      data['report'] = this.report!.toJson();
    }
    if (this.donate != null) {
      data['donate'] = this.donate!.toJson();
    }
    return data;
  }

  @override
  List<Object?> get props =>
      [productId, code, name, cardType, altText, companies, report, donate];
}
