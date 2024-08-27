// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'proxies.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Proxies {
  Map<String, Selector> get selectors => throw _privateConstructorUsedError;
  Map<String, Selectable> get all => throw _privateConstructorUsedError;
  Map<String, int?> get delays => throw _privateConstructorUsedError;

  /// Create a copy of Proxies
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProxiesCopyWith<Proxies> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProxiesCopyWith<$Res> {
  factory $ProxiesCopyWith(Proxies value, $Res Function(Proxies) then) =
      _$ProxiesCopyWithImpl<$Res, Proxies>;
  @useResult
  $Res call(
      {Map<String, Selector> selectors,
      Map<String, Selectable> all,
      Map<String, int?> delays});
}

/// @nodoc
class _$ProxiesCopyWithImpl<$Res, $Val extends Proxies>
    implements $ProxiesCopyWith<$Res> {
  _$ProxiesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Proxies
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectors = null,
    Object? all = null,
    Object? delays = null,
  }) {
    return _then(_value.copyWith(
      selectors: null == selectors
          ? _value.selectors
          : selectors // ignore: cast_nullable_to_non_nullable
              as Map<String, Selector>,
      all: null == all
          ? _value.all
          : all // ignore: cast_nullable_to_non_nullable
              as Map<String, Selectable>,
      delays: null == delays
          ? _value.delays
          : delays // ignore: cast_nullable_to_non_nullable
              as Map<String, int?>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProxiesImplCopyWith<$Res> implements $ProxiesCopyWith<$Res> {
  factory _$$ProxiesImplCopyWith(
          _$ProxiesImpl value, $Res Function(_$ProxiesImpl) then) =
      __$$ProxiesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, Selector> selectors,
      Map<String, Selectable> all,
      Map<String, int?> delays});
}

/// @nodoc
class __$$ProxiesImplCopyWithImpl<$Res>
    extends _$ProxiesCopyWithImpl<$Res, _$ProxiesImpl>
    implements _$$ProxiesImplCopyWith<$Res> {
  __$$ProxiesImplCopyWithImpl(
      _$ProxiesImpl _value, $Res Function(_$ProxiesImpl) _then)
      : super(_value, _then);

  /// Create a copy of Proxies
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectors = null,
    Object? all = null,
    Object? delays = null,
  }) {
    return _then(_$ProxiesImpl(
      selectors: null == selectors
          ? _value._selectors
          : selectors // ignore: cast_nullable_to_non_nullable
              as Map<String, Selector>,
      all: null == all
          ? _value._all
          : all // ignore: cast_nullable_to_non_nullable
              as Map<String, Selectable>,
      delays: null == delays
          ? _value._delays
          : delays // ignore: cast_nullable_to_non_nullable
              as Map<String, int?>,
    ));
  }
}

/// @nodoc

class _$ProxiesImpl extends _Proxies {
  const _$ProxiesImpl(
      {required final Map<String, Selector> selectors,
      required final Map<String, Selectable> all,
      required final Map<String, int?> delays})
      : _selectors = selectors,
        _all = all,
        _delays = delays,
        super._();

  final Map<String, Selector> _selectors;
  @override
  Map<String, Selector> get selectors {
    if (_selectors is EqualUnmodifiableMapView) return _selectors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selectors);
  }

  final Map<String, Selectable> _all;
  @override
  Map<String, Selectable> get all {
    if (_all is EqualUnmodifiableMapView) return _all;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_all);
  }

  final Map<String, int?> _delays;
  @override
  Map<String, int?> get delays {
    if (_delays is EqualUnmodifiableMapView) return _delays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_delays);
  }

  @override
  String toString() {
    return 'Proxies(selectors: $selectors, all: $all, delays: $delays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProxiesImpl &&
            const DeepCollectionEquality()
                .equals(other._selectors, _selectors) &&
            const DeepCollectionEquality().equals(other._all, _all) &&
            const DeepCollectionEquality().equals(other._delays, _delays));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_selectors),
      const DeepCollectionEquality().hash(_all),
      const DeepCollectionEquality().hash(_delays));

  /// Create a copy of Proxies
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProxiesImplCopyWith<_$ProxiesImpl> get copyWith =>
      __$$ProxiesImplCopyWithImpl<_$ProxiesImpl>(this, _$identity);
}

abstract class _Proxies extends Proxies {
  const factory _Proxies(
      {required final Map<String, Selector> selectors,
      required final Map<String, Selectable> all,
      required final Map<String, int?> delays}) = _$ProxiesImpl;
  const _Proxies._() : super._();

  @override
  Map<String, Selector> get selectors;
  @override
  Map<String, Selectable> get all;
  @override
  Map<String, int?> get delays;

  /// Create a copy of Proxies
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProxiesImplCopyWith<_$ProxiesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
