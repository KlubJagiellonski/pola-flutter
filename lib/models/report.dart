import 'package:equatable/equatable.dart';

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
