// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return _Profile.fromJson(json);
}

/// @nodoc
mixin _$Profile {
  String get name => throw _privateConstructorUsedError;
  String get path =>
      throw _privateConstructorUsedError; // subscription-userinfo
  @TrafficJsonConverter()
  Traffic? get totalTraffic => throw _privateConstructorUsedError;
  @TrafficJsonConverter()
  Traffic? get uploadTraffic => throw _privateConstructorUsedError;
  @TrafficJsonConverter()
  Traffic? get downloadTraffic => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  DateTime? get expirationTime => throw _privateConstructorUsedError; //
  DateTime get createdTime => throw _privateConstructorUsedError;

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileCopyWith<Profile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) then) =
      _$ProfileCopyWithImpl<$Res, Profile>;
  @useResult
  $Res call(
      {String name,
      String path,
      @TrafficJsonConverter() Traffic? totalTraffic,
      @TrafficJsonConverter() Traffic? uploadTraffic,
      @TrafficJsonConverter() Traffic? downloadTraffic,
      String? url,
      DateTime? expirationTime,
      DateTime createdTime});
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res, $Val extends Profile>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? path = null,
    Object? totalTraffic = freezed,
    Object? uploadTraffic = freezed,
    Object? downloadTraffic = freezed,
    Object? url = freezed,
    Object? expirationTime = freezed,
    Object? createdTime = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      totalTraffic: freezed == totalTraffic
          ? _value.totalTraffic
          : totalTraffic // ignore: cast_nullable_to_non_nullable
              as Traffic?,
      uploadTraffic: freezed == uploadTraffic
          ? _value.uploadTraffic
          : uploadTraffic // ignore: cast_nullable_to_non_nullable
              as Traffic?,
      downloadTraffic: freezed == downloadTraffic
          ? _value.downloadTraffic
          : downloadTraffic // ignore: cast_nullable_to_non_nullable
              as Traffic?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      expirationTime: freezed == expirationTime
          ? _value.expirationTime
          : expirationTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdTime: null == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileImplCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$$ProfileImplCopyWith(
          _$ProfileImpl value, $Res Function(_$ProfileImpl) then) =
      __$$ProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String path,
      @TrafficJsonConverter() Traffic? totalTraffic,
      @TrafficJsonConverter() Traffic? uploadTraffic,
      @TrafficJsonConverter() Traffic? downloadTraffic,
      String? url,
      DateTime? expirationTime,
      DateTime createdTime});
}

/// @nodoc
class __$$ProfileImplCopyWithImpl<$Res>
    extends _$ProfileCopyWithImpl<$Res, _$ProfileImpl>
    implements _$$ProfileImplCopyWith<$Res> {
  __$$ProfileImplCopyWithImpl(
      _$ProfileImpl _value, $Res Function(_$ProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? path = null,
    Object? totalTraffic = freezed,
    Object? uploadTraffic = freezed,
    Object? downloadTraffic = freezed,
    Object? url = freezed,
    Object? expirationTime = freezed,
    Object? createdTime = null,
  }) {
    return _then(_$ProfileImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      totalTraffic: freezed == totalTraffic
          ? _value.totalTraffic
          : totalTraffic // ignore: cast_nullable_to_non_nullable
              as Traffic?,
      uploadTraffic: freezed == uploadTraffic
          ? _value.uploadTraffic
          : uploadTraffic // ignore: cast_nullable_to_non_nullable
              as Traffic?,
      downloadTraffic: freezed == downloadTraffic
          ? _value.downloadTraffic
          : downloadTraffic // ignore: cast_nullable_to_non_nullable
              as Traffic?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      expirationTime: freezed == expirationTime
          ? _value.expirationTime
          : expirationTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdTime: null == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileImpl implements _Profile {
  const _$ProfileImpl(
      {required this.name,
      required this.path,
      @TrafficJsonConverter() this.totalTraffic,
      @TrafficJsonConverter() this.uploadTraffic,
      @TrafficJsonConverter() this.downloadTraffic,
      this.url,
      this.expirationTime,
      required this.createdTime});

  factory _$ProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileImplFromJson(json);

  @override
  final String name;
  @override
  final String path;
// subscription-userinfo
  @override
  @TrafficJsonConverter()
  final Traffic? totalTraffic;
  @override
  @TrafficJsonConverter()
  final Traffic? uploadTraffic;
  @override
  @TrafficJsonConverter()
  final Traffic? downloadTraffic;
  @override
  final String? url;
  @override
  final DateTime? expirationTime;
//
  @override
  final DateTime createdTime;

  @override
  String toString() {
    return 'Profile(name: $name, path: $path, totalTraffic: $totalTraffic, uploadTraffic: $uploadTraffic, downloadTraffic: $downloadTraffic, url: $url, expirationTime: $expirationTime, createdTime: $createdTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.totalTraffic, totalTraffic) ||
                other.totalTraffic == totalTraffic) &&
            (identical(other.uploadTraffic, uploadTraffic) ||
                other.uploadTraffic == uploadTraffic) &&
            (identical(other.downloadTraffic, downloadTraffic) ||
                other.downloadTraffic == downloadTraffic) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.expirationTime, expirationTime) ||
                other.expirationTime == expirationTime) &&
            (identical(other.createdTime, createdTime) ||
                other.createdTime == createdTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, path, totalTraffic,
      uploadTraffic, downloadTraffic, url, expirationTime, createdTime);

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      __$$ProfileImplCopyWithImpl<_$ProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileImplToJson(
      this,
    );
  }
}

abstract class _Profile implements Profile {
  const factory _Profile(
      {required final String name,
      required final String path,
      @TrafficJsonConverter() final Traffic? totalTraffic,
      @TrafficJsonConverter() final Traffic? uploadTraffic,
      @TrafficJsonConverter() final Traffic? downloadTraffic,
      final String? url,
      final DateTime? expirationTime,
      required final DateTime createdTime}) = _$ProfileImpl;

  factory _Profile.fromJson(Map<String, dynamic> json) = _$ProfileImpl.fromJson;

  @override
  String get name;
  @override
  String get path; // subscription-userinfo
  @override
  @TrafficJsonConverter()
  Traffic? get totalTraffic;
  @override
  @TrafficJsonConverter()
  Traffic? get uploadTraffic;
  @override
  @TrafficJsonConverter()
  Traffic? get downloadTraffic;
  @override
  String? get url;
  @override
  DateTime? get expirationTime; //
  @override
  DateTime get createdTime;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
