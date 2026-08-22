import 'dart:convert';
import 'dart:io';

import 'package:paejae_pick_cafeteria_api/cafeteria_api.dart';
import 'package:paejae_pick_cafeteria_api/cafeteria_store.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

const adminKey = 'test-administrator-key-123456';

void main() {
  group('Cafeteria API', () {
    late _MemoryCafeteriaStore store;
    late Handler handler;

    setUp(() {
      store = _MemoryCafeteriaStore();
      handler = CafeteriaApi(store: store, adminKey: adminKey).handler;
    });

    test('reports service health', () async {
      final response = await handler(
        Request('GET', Uri.parse('http://localhost/health')),
      );

      expect(response.statusCode, 200);
      expect(await _jsonBody(response), containsPair('status', 'ok'));
    });

    test('requires a date when reading a menu', () async {
      final response = await handler(
        Request(
          'GET',
          Uri.parse('http://localhost/v1/cafeteria/today'),
        ),
      );

      expect(response.statusCode, 400);
    });

    test('rejects an invalid date before reading the store', () async {
      final response = await handler(
        Request(
          'GET',
          Uri.parse(
            'http://localhost/v1/cafeteria/today?date=2026-02-30',
          ),
        ),
      );

      expect(response.statusCode, 400);
      expect(
        await _jsonBody(response),
        containsPair('error', 'Date is not valid'),
      );
    });

    test('rejects an administrator request without a key', () async {
      final response = await handler(
        _putRequest('2026-08-21', _validMenu()),
      );

      expect(response.statusCode, 401);
    });

    test('rejects an invalid menu payload', () async {
      final response = await handler(
        _putRequest(
          '2026-08-21',
          {'items': <String>[]},
          includeKey: true,
        ),
      );

      expect(response.statusCode, 400);
      expect(
        await _jsonBody(response),
        containsPair('error', 'menu_name is required'),
      );
    });

    test('rejects a request body larger than 32 KiB', () async {
      final response = await handler(
        Request(
          'PUT',
          Uri.parse(
            'http://localhost/v1/admin/cafeteria/2026-08-21',
          ),
          headers: const {
            'content-type': 'application/json',
            'x-admin-key': adminKey,
          },
          body: 'x' * (CafeteriaApi.maxRequestBytes + 1),
        ),
      );

      expect(response.statusCode, 413);
    });

    test('stores and returns an authorized menu', () async {
      final writeResponse = await handler(
        _putRequest('2026-08-21', _validMenu(), includeKey: true),
      );
      expect(writeResponse.statusCode, 200);

      final readResponse = await handler(
        Request(
          'GET',
          Uri.parse(
            'http://localhost/v1/cafeteria/today?date=2026-08-21',
          ),
        ),
      );
      final body = await _jsonBody(readResponse);

      expect(readResponse.statusCode, 200);
      expect(body['date'], '2026-08-21');
      expect(body['menu_name'], '제육덮밥');
      expect(body['items'], ['제육볶음', '쌀밥', '된장국']);
    });

    test('returns not found for a date without a menu', () async {
      final response = await handler(
        Request(
          'GET',
          Uri.parse(
            'http://localhost/v1/cafeteria/today?date=2026-08-22',
          ),
        ),
      );

      expect(response.statusCode, 404);
    });
  });

  test('file store keeps menus after reopening', () async {
    final directory = await Directory.systemTemp.createTemp(
      'paejae-pick-cafeteria-',
    );
    addTearDown(() => directory.delete(recursive: true));
    final path = '${directory.path}/menus.json';
    final first = await FileCafeteriaStore.open(path);
    await first.put(CafeteriaRecord.fromInput('2026-08-21', _validMenu()));

    final reopened = await FileCafeteriaStore.open(path);
    final stored = await reopened.findByDate('2026-08-21');

    expect(stored, isNotNull);
    expect(stored!.menuName, '제육덮밥');
  });
}

Request _putRequest(
  String date,
  Map<String, dynamic> body, {
  bool includeKey = false,
}) {
  return Request(
    'PUT',
    Uri.parse('http://localhost/v1/admin/cafeteria/$date'),
    headers: {
      'content-type': 'application/json',
      if (includeKey) 'x-admin-key': adminKey,
    },
    body: jsonEncode(body),
  );
}

Map<String, dynamic> _validMenu() {
  return {
    'menu_name': '제육덮밥',
    'items': ['제육볶음', '쌀밥', '된장국'],
    'price_label': '5,500원',
    'operation': {'opens_at': '11:30', 'closes_at': '13:30'},
    'congestion': {
      'status': 'normal',
      'estimated_wait_minutes': 6,
      'recommendation': '지금 방문 가능',
    },
  };
}

Future<Map<String, dynamic>> _jsonBody(Response response) async {
  return Map<String, dynamic>.from(
    jsonDecode(await response.readAsString()) as Map,
  );
}

class _MemoryCafeteriaStore implements CafeteriaStore {
  final records = <String, CafeteriaRecord>{};

  @override
  Future<CafeteriaRecord?> findByDate(String date) async => records[date];

  @override
  Future<void> put(CafeteriaRecord record) async {
    records[record.date] = record;
  }
}
