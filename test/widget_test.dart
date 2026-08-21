import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paejae_pick_2_app/main.dart';
import 'package:paejae_pick_2_app/smart_mobility.dart';

void main() {
  testWidgets('smart mobility hub exposes all three MVP flows', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: SmartMobilityHubScreen())),
    );

    expect(find.text('3D 실내지도'), findsOneWidget);
    expect(find.text('자율주행 픽업'), findsOneWidget);
    expect(find.text('자율배송'), findsOneWidget);
  });

  testWidgets('indoor map can search by room number', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: IndoorMapScreen()));

    await tester.enterText(find.byType(TextField), 'J408');
    await tester.pump();

    expect(find.textContaining('J408'), findsOneWidget);
  });

  testWidgets('indoor map opens with the C401 walking route', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: IndoorMapScreen()));

    expect(find.text('3D 실내 길찾기'), findsOneWidget);
    expect(find.text('길찾기 시작'), findsOneWidget);
    expect(find.textContaining('컴퓨터공학 강의실 C401'), findsOneWidget);
  });

  testWidgets('campus shuttle supports route and passenger selection', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ShuttlePickupScreen()));

    expect(find.text('교내 순환차량'), findsOneWidget);
    expect(find.text('픽업 예약하기'), findsOneWidget);
    expect(find.textContaining('다음 차량 4분 후 도착'), findsOneWidget);
  });

  testWidgets('main navigation opens the smart mobility hub', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainShell()));

    await tester.tap(find.text('스마트맵'));
    await tester.pump();

    expect(find.text('스마트 이동'), findsOneWidget);
  });
}
