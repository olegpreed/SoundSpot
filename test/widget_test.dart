import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:soundspot/main.dart';

void main() {
  testWidgets('app starts on Sign In', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: SoundSpotApp()),
    );
    await tester.pumpAndSettle();

    expect(find.text('SoundSpot'), findsOneWidget);
    expect(find.text('Continue with Spotify'), findsOneWidget);
  });
}
