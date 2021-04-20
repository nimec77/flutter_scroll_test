// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'volume_range.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$VolumeRangeTearOff {
  const _$VolumeRangeTearOff();

  _VolumeRange call({required double minVolume, required double maxVolume}) {
    return _VolumeRange(
      minVolume: minVolume,
      maxVolume: maxVolume,
    );
  }
}

/// @nodoc
const $VolumeRange = _$VolumeRangeTearOff();

/// @nodoc
mixin _$VolumeRange {
  double get minVolume => throw _privateConstructorUsedError;
  double get maxVolume => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VolumeRangeCopyWith<VolumeRange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VolumeRangeCopyWith<$Res> {
  factory $VolumeRangeCopyWith(
          VolumeRange value, $Res Function(VolumeRange) then) =
      _$VolumeRangeCopyWithImpl<$Res>;
  $Res call({double minVolume, double maxVolume});
}

/// @nodoc
class _$VolumeRangeCopyWithImpl<$Res> implements $VolumeRangeCopyWith<$Res> {
  _$VolumeRangeCopyWithImpl(this._value, this._then);

  final VolumeRange _value;
  // ignore: unused_field
  final $Res Function(VolumeRange) _then;

  @override
  $Res call({
    Object? minVolume = freezed,
    Object? maxVolume = freezed,
  }) {
    return _then(_value.copyWith(
      minVolume: minVolume == freezed
          ? _value.minVolume
          : minVolume // ignore: cast_nullable_to_non_nullable
              as double,
      maxVolume: maxVolume == freezed
          ? _value.maxVolume
          : maxVolume // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$VolumeRangeCopyWith<$Res>
    implements $VolumeRangeCopyWith<$Res> {
  factory _$VolumeRangeCopyWith(
          _VolumeRange value, $Res Function(_VolumeRange) then) =
      __$VolumeRangeCopyWithImpl<$Res>;
  @override
  $Res call({double minVolume, double maxVolume});
}

/// @nodoc
class __$VolumeRangeCopyWithImpl<$Res> extends _$VolumeRangeCopyWithImpl<$Res>
    implements _$VolumeRangeCopyWith<$Res> {
  __$VolumeRangeCopyWithImpl(
      _VolumeRange _value, $Res Function(_VolumeRange) _then)
      : super(_value, (v) => _then(v as _VolumeRange));

  @override
  _VolumeRange get _value => super._value as _VolumeRange;

  @override
  $Res call({
    Object? minVolume = freezed,
    Object? maxVolume = freezed,
  }) {
    return _then(_VolumeRange(
      minVolume: minVolume == freezed
          ? _value.minVolume
          : minVolume // ignore: cast_nullable_to_non_nullable
              as double,
      maxVolume: maxVolume == freezed
          ? _value.maxVolume
          : maxVolume // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
class _$_VolumeRange implements _VolumeRange {
  const _$_VolumeRange({required this.minVolume, required this.maxVolume})
      : assert(minVolume <= maxVolume,
            'the maximum volume must be greater than the minimum volume');

  @override
  final double minVolume;
  @override
  final double maxVolume;

  @override
  String toString() {
    return 'VolumeRange(minVolume: $minVolume, maxVolume: $maxVolume)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _VolumeRange &&
            (identical(other.minVolume, minVolume) ||
                const DeepCollectionEquality()
                    .equals(other.minVolume, minVolume)) &&
            (identical(other.maxVolume, maxVolume) ||
                const DeepCollectionEquality()
                    .equals(other.maxVolume, maxVolume)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(minVolume) ^
      const DeepCollectionEquality().hash(maxVolume);

  @JsonKey(ignore: true)
  @override
  _$VolumeRangeCopyWith<_VolumeRange> get copyWith =>
      __$VolumeRangeCopyWithImpl<_VolumeRange>(this, _$identity);
}

abstract class _VolumeRange implements VolumeRange {
  const factory _VolumeRange(
      {required double minVolume, required double maxVolume}) = _$_VolumeRange;

  @override
  double get minVolume => throw _privateConstructorUsedError;
  @override
  double get maxVolume => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$VolumeRangeCopyWith<_VolumeRange> get copyWith =>
      throw _privateConstructorUsedError;
}
