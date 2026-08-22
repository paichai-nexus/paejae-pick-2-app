import 'dart:convert';

import 'package:http/http.dart' as http;

class CafeteriaMenu {
  const CafeteriaMenu({
    required this.date,
    required this.menuName,
    required this.items,
    required this.priceLabel,
    required this.opensAt,
    required this.closesAt,
    this.congestionStatus,
    this.estimatedWaitMinutes,
    this.recommendation,
  });

  final DateTime date;
  final String menuName;
  final List<String> items;
  final String priceLabel;
  final String opensAt;
  final String closesAt;
  final String? congestionStatus;
  final int? estimatedWaitMinutes;
  final String? recommendation;

  String get cardTitle => '$menuName 카드';

  factory CafeteriaMenu.sample(DateTime date) {
    return CafeteriaMenu(
      date: DateTime(date.year, date.month, date.day),
      menuName: '돈육폭찹 정식',
      items: const ['돈육폭찹', '쌀밥', '국', '반찬'],
      priceLabel: '학생식당 기준',
      opensAt: '11:30',
      closesAt: '13:30',
    );
  }

  factory CafeteriaMenu.fromJson(Map<String, dynamic> json) {
    final operation = _mapValue(json['operation']);
    final congestion = _mapValue(json['congestion']);

    return CafeteriaMenu(
      date: DateTime.parse(_requiredString(json, 'date')),
      menuName: _requiredString(json, 'menu_name'),
      items: _stringList(json['items']),
      priceLabel: _optionalString(json['price_label']) ?? '가격 확인 필요',
      opensAt: _optionalString(operation['opens_at']) ?? '11:30',
      closesAt: _optionalString(operation['closes_at']) ?? '13:30',
      congestionStatus: _congestionLabel(
        _optionalString(congestion['status']),
      ),
      estimatedWaitMinutes: _intValue(
        congestion['estimated_wait_minutes'],
      ),
      recommendation: _optionalString(congestion['recommendation']),
    );
  }

  static Map<String, dynamic> _mapValue(Object? value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return const <String, dynamic>{};
  }

  static String _requiredString(Map<String, dynamic> json, String key) {
    final value = _optionalString(json[key]);
    if (value == null) {
      throw FormatException('Missing or empty cafeteria field: $key');
    }
    return value;
  }

  static String? _optionalString(Object? value) {
    if (value is! String) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static List<String> _stringList(Object? value) {
    if (value is! List) return const [];
    return value
        .whereType<String>()
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList(growable: false);
  }

  static int? _intValue(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }

  static String? _congestionLabel(String? value) {
    switch (value?.toLowerCase()) {
      case 'busy':
      case 'crowded':
      case '혼잡':
        return '혼잡';
      case 'normal':
      case 'moderate':
      case '보통':
        return '보통';
      case 'quiet':
      case 'available':
      case '여유':
        return '여유';
      case 'closed':
      case 'preparing':
      case '준비 중':
        return '준비 중';
      default:
        return value;
    }
  }
}

abstract class CafeteriaRemoteDataSource {
  Future<CafeteriaMenu> fetchToday(DateTime date);

  void close() {}
}

class HttpCafeteriaRemoteDataSource extends CafeteriaRemoteDataSource {
  HttpCafeteriaRemoteDataSource({
    required this.baseUri,
    required this.client,
    this.closeClient = false,
  });

  final Uri baseUri;
  final http.Client client;
  final bool closeClient;

  @override
  Future<CafeteriaMenu> fetchToday(DateTime date) async {
    final base = baseUri.toString().replaceFirst(RegExp(r'/$'), '');
    final uri = Uri.parse('$base/v1/cafeteria/today').replace(
      queryParameters: {'date': _dateKey(date)},
    );
    final response = await client.get(
      uri,
      headers: const {'Accept': 'application/json'},
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw CafeteriaApiException('Unexpected status ${response.statusCode}');
    }

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (decoded is! Map) {
      throw const FormatException('Cafeteria response must be a JSON object');
    }

    return CafeteriaMenu.fromJson(Map<String, dynamic>.from(decoded));
  }

  @override
  void close() {
    if (closeClient) client.close();
  }

  static String _dateKey(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}

class CafeteriaApiException implements Exception {
  const CafeteriaApiException(this.message);

  final String message;

  @override
  String toString() => 'CafeteriaApiException: $message';
}

class CafeteriaMenuResult {
  const CafeteriaMenuResult({
    required this.menu,
    required this.isLive,
    this.fallbackReason,
  });

  final CafeteriaMenu menu;
  final bool isLive;
  final String? fallbackReason;
}

class CafeteriaRepository {
  CafeteriaRepository({
    this.remote,
    this.timeout = const Duration(seconds: 5),
  });

  final CafeteriaRemoteDataSource? remote;
  final Duration timeout;

  Future<CafeteriaMenuResult> loadToday(DateTime date) async {
    final dataSource = remote;
    if (dataSource == null) {
      return CafeteriaMenuResult(
        menu: CafeteriaMenu.sample(date),
        isLive: false,
        fallbackReason: 'API 주소가 설정되지 않았습니다.',
      );
    }

    try {
      final menu = await dataSource.fetchToday(date).timeout(timeout);
      return CafeteriaMenuResult(menu: menu, isLive: true);
    } catch (_) {
      return CafeteriaMenuResult(
        menu: CafeteriaMenu.sample(date),
        isLive: false,
        fallbackReason: '실시간 식당 데이터를 불러오지 못했습니다.',
      );
    }
  }

  void close() => remote?.close();
}

class CafeteriaBootstrap {
  const CafeteriaBootstrap._();

  static const apiBaseUrl = String.fromEnvironment(
    'PAEJAE_PICK_API_BASE_URL',
  );

  static CafeteriaRepository build({http.Client? client}) {
    if (apiBaseUrl.trim().isEmpty) return CafeteriaRepository();

    final effectiveClient = client ?? http.Client();
    return CafeteriaRepository(
      remote: HttpCafeteriaRemoteDataSource(
        baseUri: Uri.parse(apiBaseUrl),
        client: effectiveClient,
        closeClient: client == null,
      ),
    );
  }
}
