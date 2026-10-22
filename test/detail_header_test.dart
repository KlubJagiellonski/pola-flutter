import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/pages/detail/detail.dart';
import 'package:pola_flutter/ui/menu_icon_button.dart';

void main() {
  const longName = 'Spółdzielnia Mleczarska Mlekovita';

  Future<void> showDetails(
    WidgetTester tester, {
    required String name,
    double width = 320,
    double textScale = 1,
    bool twoCompanies = false,
  }) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = Size(width, 1000);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(textScale)),
          child: child!,
        ),
        home: DetailPage(
          searchResult: SearchResult.fromJson({
            'name': name,
            'companies': twoCompanies
                ? [
                    {'name': 'First company'},
                    {'name': 'Second company'},
                  ]
                : [],
          }),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Finder headerTitle(String name) =>
      find.descendant(of: find.byType(AppBar), matching: find.text(name));

  void expectFullTitleVisible(WidgetTester tester, String name) {
    final richText = find.descendant(
      of: headerTitle(name),
      matching: find.byType(RichText),
    );
    final paragraph = tester.renderObject<RenderParagraph>(richText);
    final titleRect = tester.getRect(richText);
    final toolbarRect = tester.getRect(find.byType(AppBar));
    expect(paragraph.didExceedMaxLines, isFalse);
    // Trailing spaces can extend past a wrapped line; check visible glyphs.
    final boxes = [
      for (final word in RegExp(r'\S+').allMatches(name))
        ...paragraph.getBoxesForSelection(
          TextSelection(baseOffset: word.start, extentOffset: word.end),
        ),
    ];
    expect(boxes, isNotEmpty);
    for (final box in boxes) {
      final rect = box.toRect().shift(titleRect.topLeft);
      expect(rect.left, greaterThanOrEqualTo(titleRect.left));
      expect(rect.right, lessThanOrEqualTo(titleRect.right + 0.01));
      expect(rect.top, greaterThanOrEqualTo(toolbarRect.top));
      expect(rect.bottom, lessThanOrEqualTo(toolbarRect.bottom));
    }
    expect(
      titleRect.left,
      greaterThanOrEqualTo(tester.getRect(find.byType(BackButton)).right),
    );
    if (find.byType(MenuIconButton).evaluate().isNotEmpty) {
      expect(
        titleRect.right,
        lessThanOrEqualTo(tester.getRect(find.byType(MenuIconButton)).left),
      );
    }
    expect(tester.takeException(), isNull);
  }

  for (final width in [320.0, 412.0]) {
    for (final scale in [1.0, 2.0]) {
      testWidgets('full title fits at width $width and text scale $scale', (
        tester,
      ) async {
        await showDetails(
          tester,
          name: longName,
          width: width,
          textScale: scale,
        );
        expectFullTitleVisible(tester, longName);
        final originalPosition = tester.getTopLeft(headerTitle(longName));
        await tester.pump(const Duration(seconds: 5));
        expect(tester.getTopLeft(headerTitle(longName)), originalPosition);
        expectFullTitleVisible(tester, longName);
      });
    }
  }

  testWidgets('two-company details also show the full header title', (
    tester,
  ) async {
    await showDetails(tester, name: longName, twoCompanies: true);
    expectFullTitleVisible(tester, longName);
  });

  testWidgets('short titles retain the standard toolbar height', (
    tester,
  ) async {
    await showDetails(tester, name: 'Pola');
    expect(tester.getSize(find.byType(AppBar)).height, kToolbarHeight);
    expectFullTitleVisible(tester, 'Pola');
  });
}
