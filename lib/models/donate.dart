
import 'package:equatable/equatable.dart';

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
  List<Object?> get props => [showButton,url,title];
}
