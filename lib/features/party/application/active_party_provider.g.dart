// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_party_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The party id the current user is actively in (host or participant), or
/// null if none — see CLAUDE.md's Single Active Party rule. This is the
/// single source of truth AppShell (routing/bottom-chrome decisions) and the
/// Party tab (empty-state vs redirect) both read, instead of each screen
/// guessing locally. Holding just an id is a stub: once the party
/// repository exists, this becomes real party data fetched by id rather
/// than a bare string. `keepAlive: true` because a go_router `redirect`
/// reads this via `ref.read` outside any widget's watch — the default
/// autoDispose behavior would reset it to null between reads whenever no
/// widget happened to be watching it at that moment.

@ProviderFor(ActiveParty)
final activePartyProvider = ActivePartyProvider._();

/// The party id the current user is actively in (host or participant), or
/// null if none — see CLAUDE.md's Single Active Party rule. This is the
/// single source of truth AppShell (routing/bottom-chrome decisions) and the
/// Party tab (empty-state vs redirect) both read, instead of each screen
/// guessing locally. Holding just an id is a stub: once the party
/// repository exists, this becomes real party data fetched by id rather
/// than a bare string. `keepAlive: true` because a go_router `redirect`
/// reads this via `ref.read` outside any widget's watch — the default
/// autoDispose behavior would reset it to null between reads whenever no
/// widget happened to be watching it at that moment.
final class ActivePartyProvider
    extends $NotifierProvider<ActiveParty, String?> {
  /// The party id the current user is actively in (host or participant), or
  /// null if none — see CLAUDE.md's Single Active Party rule. This is the
  /// single source of truth AppShell (routing/bottom-chrome decisions) and the
  /// Party tab (empty-state vs redirect) both read, instead of each screen
  /// guessing locally. Holding just an id is a stub: once the party
  /// repository exists, this becomes real party data fetched by id rather
  /// than a bare string. `keepAlive: true` because a go_router `redirect`
  /// reads this via `ref.read` outside any widget's watch — the default
  /// autoDispose behavior would reset it to null between reads whenever no
  /// widget happened to be watching it at that moment.
  ActivePartyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activePartyProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activePartyHash();

  @$internal
  @override
  ActiveParty create() => ActiveParty();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$activePartyHash() => r'bef9c9b2129470616038b441210969124f9b0abc';

/// The party id the current user is actively in (host or participant), or
/// null if none — see CLAUDE.md's Single Active Party rule. This is the
/// single source of truth AppShell (routing/bottom-chrome decisions) and the
/// Party tab (empty-state vs redirect) both read, instead of each screen
/// guessing locally. Holding just an id is a stub: once the party
/// repository exists, this becomes real party data fetched by id rather
/// than a bare string. `keepAlive: true` because a go_router `redirect`
/// reads this via `ref.read` outside any widget's watch — the default
/// autoDispose behavior would reset it to null between reads whenever no
/// widget happened to be watching it at that moment.

abstract class _$ActiveParty extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
