import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_party_provider.g.dart';

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
@Riverpod(keepAlive: true)
class ActiveParty extends _$ActiveParty {
  @override
  String? build() => null;

  void set(String partyId) => state = partyId;

  void clear() => state = null;
}
