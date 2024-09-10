 import 'package:flutter/material.dart';

class ScoreSectionData {
  final int plCapital;
  final bool plWorkers;
  final bool plRnD;
  final bool plRegistered;
  final bool plNotGlobEnt;
  final int plScore;

  ScoreSectionData({required this.plCapital, required this.plWorkers, required this.plRnD, required this.plRegistered, required this.plNotGlobEnt, required this.plScore});
}

 class ScoreSection extends StatelessWidget {
 final ScoreSectionData data;

  const ScoreSection({super.key, required this.data});
 @override
  Widget build(BuildContext context) {
 
    throw UnimplementedError();
  }
 }
 