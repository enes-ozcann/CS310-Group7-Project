import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartpackapp/main.dart';
import 'package:smartpackapp/bc_baler/bc_app_shell.dart';
import 'package:smartpackapp/ne_nehir/ne_main.dart';
import 'package:smartpackapp/ne_nehir/ne_widgets.dart';
import 'package:smartpackapp/eo_enes/eo_explore_screen.dart';
import 'package:smartpackapp/eo_enes/eo_overview_screen.dart';
import 'package:smartpackapp/ss_seyma/ss_budget_tab.dart';
import 'package:smartpackapp/ab_alara/ab_packing_checklist_page.dart';

void main() {
  testWidgets('login validates fields and opens the shared app', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const SmartPackApp());
    expect(find.byType(LoginScreen), findsOneWidget);
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();
    expect(find.text('Email cannot be empty'), findsOneWidget);
    expect(find.byType(AppShell), findsNothing);
    await tester.enterText(find.byType(TextFormField).at(0), 'enes@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'demo1234');
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();
    expect(find.byType(AppShell), findsOneWidget);
    expect(find.text('Plan New Trip'), findsOneWidget);
    expect(tester.takeException(), isNull);

    final openTrip = find.text('Open Trip Hub (Weather, Pack, Budget)').first;
    await tester.ensureVisible(openTrip);
    await tester.tap(openTrip);
    await tester.pumpAndSettle();
    expect(find.byType(OverviewScreen), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Packing Checklist'));
    await tester.pumpAndSettle();
    expect(find.byType(PackingChecklistPage), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Budget Tracking'));
    await tester.pumpAndSettle();
    expect(find.byType(BudgetTab), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Explore').last);
    await tester.pumpAndSettle();
    expect(find.byType(ExploreScreen), findsOneWidget);
    await tester.drag(find.byType(ListView).hitTestable().first, const Offset(0, -280));
    await tester.pumpAndSettle();
    await tester.tap(find.text('View Details').first);
    await tester.pumpAndSettle();
    expect(find.byType(PlaceDetailsScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
