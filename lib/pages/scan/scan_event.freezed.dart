// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ScanEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String barcode) barcodeScanned,
    required TResult Function() alertDialogDismissed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String barcode)? barcodeScanned,
    TResult? Function()? alertDialogDismissed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String barcode)? barcodeScanned,
    TResult Function()? alertDialogDismissed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BarcodeScanned value) barcodeScanned,
    required TResult Function(AlertDialogDismissed value) alertDialogDismissed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BarcodeScanned value)? barcodeScanned,
    TResult? Function(AlertDialogDismissed value)? alertDialogDismissed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BarcodeScanned value)? barcodeScanned,
    TResult Function(AlertDialogDismissed value)? alertDialogDismissed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanEventCopyWith<$Res> {
  factory $ScanEventCopyWith(ScanEvent value, $Res Function(ScanEvent) then) =
      _$ScanEventCopyWithImpl<$Res, ScanEvent>;
}

/// @nodoc
class _$ScanEventCopyWithImpl<$Res, $Val extends ScanEvent>
    implements $ScanEventCopyWith<$Res> {
  _$ScanEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BarcodeScannedImplCopyWith<$Res> {
  factory _$$BarcodeScannedImplCopyWith(_$BarcodeScannedImpl value,
          $Res Function(_$BarcodeScannedImpl) then) =
      __$$BarcodeScannedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String barcode});
}

/// @nodoc
class __$$BarcodeScannedImplCopyWithImpl<$Res>
    extends _$ScanEventCopyWithImpl<$Res, _$BarcodeScannedImpl>
    implements _$$BarcodeScannedImplCopyWith<$Res> {
  __$$BarcodeScannedImplCopyWithImpl(
      _$BarcodeScannedImpl _value, $Res Function(_$BarcodeScannedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? barcode = null,
  }) {
    return _then(_$BarcodeScannedImpl(
      null == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BarcodeScannedImpl implements BarcodeScanned {
  const _$BarcodeScannedImpl(this.barcode);

  @override
  final String barcode;

  @override
  String toString() {
    return 'ScanEvent.barcodeScanned(barcode: $barcode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BarcodeScannedImpl &&
            (identical(other.barcode, barcode) || other.barcode == barcode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, barcode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BarcodeScannedImplCopyWith<_$BarcodeScannedImpl> get copyWith =>
      __$$BarcodeScannedImplCopyWithImpl<_$BarcodeScannedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String barcode) barcodeScanned,
    required TResult Function() alertDialogDismissed,
  }) {
    return barcodeScanned(barcode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String barcode)? barcodeScanned,
    TResult? Function()? alertDialogDismissed,
  }) {
    return barcodeScanned?.call(barcode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String barcode)? barcodeScanned,
    TResult Function()? alertDialogDismissed,
    required TResult orElse(),
  }) {
    if (barcodeScanned != null) {
      return barcodeScanned(barcode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BarcodeScanned value) barcodeScanned,
    required TResult Function(AlertDialogDismissed value) alertDialogDismissed,
  }) {
    return barcodeScanned(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BarcodeScanned value)? barcodeScanned,
    TResult? Function(AlertDialogDismissed value)? alertDialogDismissed,
  }) {
    return barcodeScanned?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BarcodeScanned value)? barcodeScanned,
    TResult Function(AlertDialogDismissed value)? alertDialogDismissed,
    required TResult orElse(),
  }) {
    if (barcodeScanned != null) {
      return barcodeScanned(this);
    }
    return orElse();
  }
}

abstract class BarcodeScanned implements ScanEvent {
  const factory BarcodeScanned(final String barcode) = _$BarcodeScannedImpl;

  String get barcode;
  @JsonKey(ignore: true)
  _$$BarcodeScannedImplCopyWith<_$BarcodeScannedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AlertDialogDismissedImplCopyWith<$Res> {
  factory _$$AlertDialogDismissedImplCopyWith(_$AlertDialogDismissedImpl value,
          $Res Function(_$AlertDialogDismissedImpl) then) =
      __$$AlertDialogDismissedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AlertDialogDismissedImplCopyWithImpl<$Res>
    extends _$ScanEventCopyWithImpl<$Res, _$AlertDialogDismissedImpl>
    implements _$$AlertDialogDismissedImplCopyWith<$Res> {
  __$$AlertDialogDismissedImplCopyWithImpl(_$AlertDialogDismissedImpl _value,
      $Res Function(_$AlertDialogDismissedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AlertDialogDismissedImpl implements AlertDialogDismissed {
  const _$AlertDialogDismissedImpl();

  @override
  String toString() {
    return 'ScanEvent.alertDialogDismissed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertDialogDismissedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String barcode) barcodeScanned,
    required TResult Function() alertDialogDismissed,
  }) {
    return alertDialogDismissed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String barcode)? barcodeScanned,
    TResult? Function()? alertDialogDismissed,
  }) {
    return alertDialogDismissed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String barcode)? barcodeScanned,
    TResult Function()? alertDialogDismissed,
    required TResult orElse(),
  }) {
    if (alertDialogDismissed != null) {
      return alertDialogDismissed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BarcodeScanned value) barcodeScanned,
    required TResult Function(AlertDialogDismissed value) alertDialogDismissed,
  }) {
    return alertDialogDismissed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BarcodeScanned value)? barcodeScanned,
    TResult? Function(AlertDialogDismissed value)? alertDialogDismissed,
  }) {
    return alertDialogDismissed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BarcodeScanned value)? barcodeScanned,
    TResult Function(AlertDialogDismissed value)? alertDialogDismissed,
    required TResult orElse(),
  }) {
    if (alertDialogDismissed != null) {
      return alertDialogDismissed(this);
    }
    return orElse();
  }
}

abstract class AlertDialogDismissed implements ScanEvent {
  const factory AlertDialogDismissed() = _$AlertDialogDismissedImpl;
}
