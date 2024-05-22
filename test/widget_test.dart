// widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sunflower/main.dart';

void main() {
  testWidgets('Sunflower app has a title and slider', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Sunflower());

    // Verify that our app has a title.
    expect(find.text('Sunflower'), findsOneWidget);

    // Verify that our app has a slider.
    expect(find.byType(Slider), findsOneWidget);

    // Verify that initial seed count text is displayed correctly.
    expect(find.text('Showing 125 seeds'), findsOneWidget);
  });

  testWidgets('Slider updates seed count text', (WidgetTester tester) async {
    await tester.pumpWidget(const Sunflower());

    // Find the slider.
    final sliderFinder = find.byType(Slider);

    // Verify the initial state of the slider.
    Slider slider = tester.widget(sliderFinder);
    expect(slider.value, 125);

    // Drag the slider to the maximum value.
    await tester.drag(sliderFinder, const Offset(300, 0));
    await tester.pumpAndSettle();

    // Verify the seed count text has updated.
    expect(find.text('Showing 250 seeds'), findsOneWidget);

    // Drag the slider to the minimum value.
    await tester.drag(sliderFinder, const Offset(-300, 0));
    await tester.pumpAndSettle();

    // Verify the seed count text has updated.
    expect(find.text('Showing 1 seed'), findsOneWidget);
  });

  testWidgets('Sunflower widget displays correct number of seeds', (WidgetTester tester) async {
    await tester.pumpWidget(const Sunflower());

    // Initial state should display 125 seeds.
    expect(find.byType(Dot), findsNWidgets(125));

    // Find the slider and move it to 250.
    final sliderFinder = find.byType(Slider);
    await tester.drag(sliderFinder, const Offset(300, 0));
    await tester.pumpAndSettle();

    // Verify the number of Dot widgets is updated.
    expect(find.byType(Dot), findsNWidgets(250));

    // Move the slider to 1.
    await tester.drag(sliderFinder, const Offset(-300, 0));
    await tester.pumpAndSettle();

    // Verify the number of Dot widgets is updated.
    expect(find.byType(Dot), findsNWidgets(1));
  });
}
