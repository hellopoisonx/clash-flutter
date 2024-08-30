// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logs.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$logsHash() => r'203766458f8199d2076fe82bbee05b18826a4038';

/// See also [logs].
@ProviderFor(logs)
final logsProvider = AutoDisposeStreamProvider<List<Log>>.internal(
  logs,
  name: r'logsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$logsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LogsRef = AutoDisposeStreamProviderRef<List<Log>>;
String _$filteredLogsHash() => r'fd9a671000584c2d81d1bc96d6fc2fb1d610c336';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [filteredLogs].
@ProviderFor(filteredLogs)
const filteredLogsProvider = FilteredLogsFamily();

/// See also [filteredLogs].
class FilteredLogsFamily extends Family {
  /// See also [filteredLogs].
  const FilteredLogsFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'filteredLogsProvider';

  /// See also [filteredLogs].
  FilteredLogsProvider call(
    String query,
    Type type,
  ) {
    return FilteredLogsProvider(
      query,
      type,
    );
  }

  @visibleForOverriding
  @override
  FilteredLogsProvider getProviderOverride(
    covariant FilteredLogsProvider provider,
  ) {
    return call(
      provider.query,
      provider.type,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<List<Log>> Function(FilteredLogsRef ref) create) {
    return _$FilteredLogsFamilyOverride(this, create);
  }
}

class _$FilteredLogsFamilyOverride implements FamilyOverride {
  _$FilteredLogsFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<Log>> Function(FilteredLogsRef ref) create;

  @override
  final FilteredLogsFamily overriddenFamily;

  @override
  FilteredLogsProvider getProviderOverride(
    covariant FilteredLogsProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [filteredLogs].
class FilteredLogsProvider extends AutoDisposeFutureProvider<List<Log>> {
  /// See also [filteredLogs].
  FilteredLogsProvider(
    String query,
    Type type,
  ) : this._internal(
          (ref) => filteredLogs(
            ref as FilteredLogsRef,
            query,
            type,
          ),
          from: filteredLogsProvider,
          name: r'filteredLogsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredLogsHash,
          dependencies: FilteredLogsFamily._dependencies,
          allTransitiveDependencies:
              FilteredLogsFamily._allTransitiveDependencies,
          query: query,
          type: type,
        );

  FilteredLogsProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
    required this.type,
  }) : super.internal();

  final String query;
  final Type type;

  @override
  Override overrideWith(
    FutureOr<List<Log>> Function(FilteredLogsRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredLogsProvider._internal(
        (ref) => create(ref as FilteredLogsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
        type: type,
      ),
    );
  }

  @override
  (
    String,
    Type,
  ) get argument {
    return (
      query,
      type,
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Log>> createElement() {
    return _FilteredLogsProviderElement(this);
  }

  FilteredLogsProvider _copyWith(
    FutureOr<List<Log>> Function(FilteredLogsRef ref) create,
  ) {
    return FilteredLogsProvider._internal(
      (ref) => create(ref as FilteredLogsRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      query: query,
      type: type,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredLogsProvider &&
        other.query == query &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FilteredLogsRef on AutoDisposeFutureProviderRef<List<Log>> {
  /// The parameter `query` of this provider.
  String get query;

  /// The parameter `type` of this provider.
  Type get type;
}

class _FilteredLogsProviderElement
    extends AutoDisposeFutureProviderElement<List<Log>> with FilteredLogsRef {
  _FilteredLogsProviderElement(super.provider);

  @override
  String get query => (origin as FilteredLogsProvider).query;
  @override
  Type get type => (origin as FilteredLogsProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
