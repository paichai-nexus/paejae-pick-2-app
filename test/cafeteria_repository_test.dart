import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:paejae_pick_2_app/features/cafeteria/cafeteria_repository.dart';

void main() {
  group('CafeteriaMenu', () {
    test('parses the live menu contract', () {
      final menu = CafeteriaMenu.fromJson({
        'date': '2026-08-21',
        'menu_name': '제육덮밥',
        'items': ['제육볶음', '쌀밥', '된장국'],
        'price_label': '5,500원',
        'operation': {'opens_at': '11:20', 'closes_at': '13:40'},
        'congestion': {
          'status': 'busy',
          'estimated_wait_minutes': 12,
          'recommendation': '12:40 이후 방문 추천',
        },
      });

      expect(menu.menuName, '제육덮밥');
      expect(menu.items, hasLength(3));
      expect(menu.priceLabel, '5,500원');
      expect(menu.opensAt, '11:20');
      expect(menu.closesAt, '13:40');
      expect(menu.congestionStatus, '혼잡');
      expect(menu.estimatedWaitMinutes, 12);
    });

    test('rejects a response without a menu name', () {
      expect(
        () => CafeteriaMenu.fromJson({'date': '2026-08-21'}),
        throwsFormatException,
      );
    });
  });

  test('HTTP source requests the dated cafeteria endpoint', () async {
    final client = MockClient((request) async {
      expect(request.url.path, '/api/v1/cafeteria/today');
      expect(request.url.queryParameters['date'], '2026-08-21');
      expect(request.headers['Accept'], 'application/json');

      return http.Response(
        '''
        {
          "date": "2026-08-21",
          "menu_name": "불고기 정식",
          "items": ["불고기", "쌀밥"],
          "price_label": "5,500원",
          "operation": {"opens_at": "11:30", "closes_at": "13:30"},
          "congestion": {"status": "normal", "estimated_wait_minutes": 6}
        }
        ''',
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    });
    final source = HttpCafeteriaRemoteDataSource(
      baseUri: Uri.parse('https://example.com/api'),
      client: client,
    );

    final result = await CafeteriaRepository(remote: source).loadToday(
      DateTime(2026, 8, 21),
    );

    expect(result.isLive, isTrue);
    expect(result.menu.menuName, '불고기 정식');
    expect(result.menu.congestionStatus, '보통');
  });

  test('repository falls back to sample data when the API fails', () async {
    final result = await CafeteriaRepository(
      remote: _FailingDataSource(),
    ).loadToday(DateTime(2026, 8, 21));

    expect(result.isLive, isFalse);
    expect(result.menu.menuName, '돈육폭찹 정식');
    expect(result.fallbackReason, isNotEmpty);
  });
}

class _FailingDataSource extends CafeteriaRemoteDataSource {
  @override
  Future<CafeteriaMenu> fetchToday(DateTime date) {
    throw const CafeteriaApiException('offline');
  }
}
