/// Centralized route path/name constants. Keep the router, navigation calls,
/// and any deep-link construction pointed at these rather than raw strings.
class AppRoutes {
  const AppRoutes._();

  static const signIn = '/sign-in';

  static const map = '/map';
  static const party = '/party';
  static const profile = '/profile';

  static const partyCreate = '/party/create';
  static const partyPreview = '/party/preview/:partyId';
  static const partyActive = '/party/active/:partyId';
  static const partySettings = '/party/active/:partyId/settings';
  static const trackSearch = '/party/active/:partyId/track-search';

  static const hostSearch = '/profile/search';
  static const otherUserProfile = '/profile/:userId';
  static const connections = '/profile/:userId/connections';

  static String partyPreviewPath(String partyId) => '/party/preview/$partyId';

  static String partyActivePath(String partyId) => '/party/active/$partyId';

  static String partySettingsPath(String partyId) =>
      '/party/active/$partyId/settings';

  static String trackSearchPath(String partyId) =>
      '/party/active/$partyId/track-search';

  static String otherUserProfilePath(String userId) => '/profile/$userId';

  static String connectionsPath(String userId, {required bool followers}) =>
      '/profile/$userId/connections?type=${followers ? 'followers' : 'following'}';
}
