import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pola_flutter/models/replacement.dart';

part 'replacement_event.freezed.dart';

@freezed
class ReplacementEvent with _$ReplacementEvent {
  const factory ReplacementEvent.replacementTapped(Replacement replacement) = ReplacementTapped;
  const factory ReplacementEvent.navigationCompleted() = NavigationCompleted;
  const factory ReplacementEvent.alertDialogDismissed() = AlertDialogDismissed;
}
