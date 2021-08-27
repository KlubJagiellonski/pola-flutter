
import 'package:equatable/equatable.dart';

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
