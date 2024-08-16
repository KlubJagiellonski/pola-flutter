// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'version_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VersionState {
  String? get version => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VersionStateCopyWith<VersionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VersionStateCopyWith<$Res> {
  factory $VersionStateCopyWith(
          VersionState value, $Res Function(VersionState) then) =
      _$VersionStateCopyWithImpl<$Res, VersionState>;
  @useResult
  $Res call({String? version});
}

/// @nodoc
class _$VersionStateCopyWithImpl<$Res, $Val extends VersionState>
    implements $VersionStateCopyWith<$Res> {
  _$VersionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = freezed,
  }) {
    return _then(_value.copyWith(
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $VersionStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? version});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$VersionStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = freezed,
  }) {
    return _then(_$InitialImpl(
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements Initial {
  const _$InitialImpl({this.version = null});

  @override
  @JsonKey()
  final String? version;

  @override
  String toString() {
    return 'VersionState(version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.version, version) || other.version == version));
  }

  @override
  int get hashCode => Object.hash(runtimeType, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);
}

abstract class Initial implements VersionState {
  const factory Initial({final String? version}) = _$InitialImpl;

  @override
  String? get version;
  @override
  @JsonKey(ignore: true)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VersionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() onApear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? onApear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? onApear,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(onApear value) onApear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(onApear value)? onApear,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(onApear value)? onApear,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VersionEventCopyWith<$Res> {
  factory $VersionEventCopyWith(
          VersionEvent value, $Res Function(VersionEvent) then) =
      _$VersionEventCopyWithImpl<$Res, VersionEvent>;
}

/// @nodoc
class _$VersionEventCopyWithImpl<$Res, $Val extends VersionEvent>
    implements $VersionEventCopyWith<$Res> {
  _$VersionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$onApearImplCopyWith<$Res> {
  factory _$$onApearImplCopyWith(
          _$onApearImpl value, $Res Function(_$onApearImpl) then) =
      __$$onApearImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$onApearImplCopyWithImpl<$Res>
    extends _$VersionEventCopyWithImpl<$Res, _$onApearImpl>
    implements _$$onApearImplCopyWith<$Res> {
  __$$onApearImplCopyWithImpl(
      _$onApearImpl _value, $Res Function(_$onApearImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$onApearImpl implements onApear {
  const _$onApearImpl();

  @override
  String toString() {
    return 'VersionEvent.onApear()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$onApearImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() onApear,
  }) {
    return onApear();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? onApear,
  }) {
    return onApear?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? onApear,
    required TResult orElse(),
  }) {
    if (onApear != null) {
      return onApear();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(onApear value) onApear,
  }) {
    return onApear(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(onApear value)? onApear,
  }) {
    return onApear?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(onApear value)? onApear,
    required TResult orElse(),
  }) {
    if (onApear != null) {
      return onApear(this);
    }
    return orElse();
  }
}

abstract class onApear implements VersionEvent {
  const factory onApear() = _$onApearImpl;
}
