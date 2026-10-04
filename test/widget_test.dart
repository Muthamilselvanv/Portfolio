import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/src/app/app.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  setUp(() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });
  testWidgets('portfolio introduces the developer and exposes navigation', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 700));

    expect(find.text('Muthamilselvan V'), findsWidgets);
    expect(find.text('Flutter Mobile App Developer'), findsWidgets);
    expect(find.text('View Projects'), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);
  });

  testWidgets('mobile layout provides a navigation drawer', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 700));

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold).first);
    expect(scaffold.drawer, isNotNull);
    expect(tester.takeException(), isNull);
  });

  for (final size in <Size>[
    const Size(320, 700),
    const Size(360, 800),
    const Size(375, 812),
    const Size(390, 844),
    const Size(412, 915),
    const Size(600, 900),
    const Size(768, 1024),
    const Size(900, 900),
    const Size(1024, 768),
    const Size(1280, 800),
    const Size(1366, 768),
    const Size(1440, 900),
    const Size(1920, 1080),
  ]) {
    testWidgets('has no layout exception at ${size.width.toInt()}px', (
      tester,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const PortfolioApp());
      await tester.pump(const Duration(milliseconds: 700));

      expect(tester.takeException(), isNull);
    });
  }
}
