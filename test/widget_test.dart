import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paejae_pick_2_app/main.dart';
import 'package:paejae_pick_2_app/features/cafeteria/cafeteria_repository.dart';
import 'package:paejae_pick_2_app/smart_mobility.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('smart mobility hub exposes all three MVP flows', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: SmartMobilityHubScreen())),
    );

    expect(find.text('3D 실내 길찾기'), findsOneWidget);
    expect(find.text('교내 순환차량'), findsOneWidget);
    expect(find.text('자율배송'), findsOneWidget);
  });

  testWidgets('indoor map can search by room number', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: IndoorMapScreen()));

    await tester.enterText(find.byType(TextField), 'J408');
    await tester.pump();

    expect(find.text('J408 · 원예산림 연구공간 (샘플)'), findsOneWidget);
  });

  testWidgets('indoor map opens with the C401 walking route', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: IndoorMapScreen()));

    expect(find.text('3D 실내 길찾기'), findsOneWidget);
    expect(find.text('길찾기 시작'), findsOneWidget);
    expect(find.textContaining('컴퓨터공학 강의실 C401'), findsOneWidget);
  });

  testWidgets('campus shuttle supports route and passenger selection', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ShuttlePickupScreen()));

    expect(find.text('교내 순환차량'), findsOneWidget);
    expect(find.text('픽업 예약하기'), findsOneWidget);
    expect(find.textContaining('다음 차량 4분 후 도착'), findsOneWidget);
  });

  testWidgets('delivery screen exposes ROS2 tracking status', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: DeliveryRobotScreen()));

    expect(find.text('ROS2 연동 예정'), findsOneWidget);
    expect(find.text('배송로봇 NEXUS-01'), findsOneWidget);
    expect(find.text('배송 상태 확인'), findsOneWidget);
    expect(find.text('배터리 82%'), findsOneWidget);
  });

  testWidgets('main navigation opens the smart mobility hub', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainShell()));

    await tester.tap(find.text('스마트맵'));
    await tester.pump();

    expect(find.text('스마트 이동'), findsOneWidget);
  });

  testWidgets('cafeteria screen surfaces live API data', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final repository = CafeteriaRepository(
      remote: _StaticCafeteriaDataSource(
        CafeteriaMenu(
          date: DateTime(2026, 8, 21),
          menuName: '제육덮밥',
          items: const ['제육볶음', '쌀밥', '된장국'],
          priceLabel: '5,500원',
          opensAt: '11:30',
          closesAt: '13:30',
          congestionStatus: '보통',
          estimatedWaitMinutes: 6,
        ),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(home: CafeteriaDetailScreen(repository: repository)),
    );
    await tester.pumpAndSettle();

    expect(find.text('실시간 식당 API 연결'), findsOneWidget);
    expect(find.text('제육덮밥'), findsNWidgets(2));
    expect(find.text('예상 대기 시간: 약 6분'), findsOneWidget);
  });
}

class _StaticCafeteriaDataSource extends CafeteriaRemoteDataSource {
  _StaticCafeteriaDataSource(this.menu);

  final CafeteriaMenu menu;

  @override
  Future<CafeteriaMenu> fetchToday(DateTime date) async => menu;
}
