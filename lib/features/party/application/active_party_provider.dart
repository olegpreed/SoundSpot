import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_party_provider.g.dart';

/// The party id the current user is actively in (host or participant), or
/// null if none — see CLAUDE.md's Single Active Party rule. `keepAlive:
/// true` because go_router's `redirect` reads this via `ref.read` outside
/// any widget's watch, and the default autoDispose would reset it to null
/// whenever nothing happened to be watching.
@Riverpod(keepAlive: true)
class ActiveParty extends _$ActiveParty {
  @override
  String? build() => null;

  void set(String partyId) => state = partyId;

  void clear() => state = null;
}
