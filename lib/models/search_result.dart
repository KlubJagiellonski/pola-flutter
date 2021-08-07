import 'package:equatable/equatable.dart';

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

class Company extends Equatable {
  String? name;
  int? plCapital;
  String? plCapitalNotes;
  int? plWorkers;
  String? plWorkersNotes;
  int? plRnD;
  String? plRnDNotes;
  int? plRegistered;
  String? plRegisteredNotes;
  int? plNotGlobEnt;
  String? plNotGlobEntNotes;
  int? plScore;
  bool? isFriend;
  String? description;

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
      required this.description});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    plCapital = json['plCapital'];
    plCapitalNotes = json['plCapital_notes'];
    plWorkers = json['plWorkers'];
    plWorkersNotes = json['plWorkers_notes'];
    plRnD = json['plRnD'];
    plRnDNotes = json['plRnD_notes'];
    plRegistered = json['plRegistered'];
    plRegisteredNotes = json['plRegistered_notes'];
    plNotGlobEnt = json['plNotGlobEnt'];
    plNotGlobEntNotes = json['plNotGlobEnt_notes'];
    plScore = json['plScore'];
    isFriend = json['is_friend'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['plCapital'] = this.plCapital;
    data['plCapital_notes'] = this.plCapitalNotes;
    data['plWorkers'] = this.plWorkers;
    data['plWorkers_notes'] = this.plWorkersNotes;
    data['plRnD'] = this.plRnD;
    data['plRnD_notes'] = this.plRnDNotes;
    data['plRegistered'] = this.plRegistered;
    data['plRegistered_notes'] = this.plRegisteredNotes;
    data['plNotGlobEnt'] = this.plNotGlobEnt;
    data['plNotGlobEnt_notes'] = this.plNotGlobEntNotes;
    data['plScore'] = this.plScore;
    data['is_friend'] = this.isFriend;
    data['description'] = this.description;
    return data;
  }

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
        description
      ];
  int? getScore(){
    return plScore;
  }
}

class Report extends Equatable{
  String? text;
  String? buttonText;
  String? buttonType;

  Report(
      {required this.text, required this.buttonText, required this.buttonType});

  Report.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    buttonText = json['button_text'];
    buttonType = json['button_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['button_text'] = this.buttonText;
    data['button_type'] = this.buttonType;
    return data;
  }

  @override
  List<Object?> get props => [text,buttonText,buttonType];
}

class Donate extends Equatable{
  bool? showButton;
  String? url;
  String? title;

  Donate({required this.showButton, required this.url, required this.title});

  Donate.fromJson(Map<String, dynamic> json) {
    showButton = json['show_button'];
    url = json['url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['show_button'] = this.showButton;
    data['url'] = this.url;
    data['title'] = this.title;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [showButton,url,title];
}
