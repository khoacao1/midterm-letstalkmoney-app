import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:letstalkmoney_app/main.dart' as app;

void main() {
  group('Testing App Performance Tests', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    testWidgets('Study Test', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final fname = find.byKey(Key('fname'));
      final lname = find.byKey(Key('lname'));
      final email = find.byKey(Key('email'));
      final password = find.byKey(Key('password'));
      final button = find.byKey(Key('register'));
      final gametab = find.byKey(Key('gametab'));

      await tester.enterText(fname, 'Test');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(lname, 'Integration');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(email, 'Integration@testmail.com');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.enterText(password, 'password');
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(button);
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(gametab);
      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(find.text('This is Games Room'), findsOneWidget);
    });
  });
}
