import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_stars/core/shared_widgets/custom_cached_network_image.dart';
import 'package:movie_stars/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Ensuring app shows popular people and their basic info ',
          (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      app.main();
      await tester.pumpAndSettle();

      final personTileFinder = find.byType(ListTile);
      expect(personTileFinder, findsWidgets);

      await tester.tap(personTileFinder.first);
      await tester.pumpAndSettle();

      final nameFinder = find.textContaining('Birthday:');
      expect(nameFinder, findsOneWidget);

      final imageFinder = find.byType(
          CustomCachedNetworkImage);
      await tester.fling(imageFinder.first, const Offset(0, -300), 1000);
      await tester.pumpAndSettle();
      expect(imageFinder, findsWidgets);

      await tester.tap(imageFinder.first);
      await tester.pumpAndSettle();
      // TODO: Fix image path handling to enable full flow test till 'Full Image' page.

      // debugDumpApp();
      // expect(find.text('Full Image'), findsOneWidget);
      // final fullImageText = find.text("Full Image");
      // expect(fullImageText, findsOneWidget);
      // final downloadIconFinder = find.byIcon(Icons.download);
      // expect(downloadIconFinder, findsOneWidget);
      // await tester.tap(downloadIconFinder);
      // await tester.pump();
      // await tester.pump(const Duration(seconds: 2));
      //
      // final snackBarFinder = find.textContaining('Image Saved Successfully');
      // expect(snackBarFinder, findsOneWidget);

    });
  });
}