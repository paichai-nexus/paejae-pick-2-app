import 'dart:convert';
import 'dart:io';

class CafeteriaRecord {
  const CafeteriaRecord({
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

  final String date;
  final String menuName;
  final List<String> items;
  final String priceLabel;
  final String opensAt;
  final String closesAt;
  final String? congestionStatus;
  final int? estimatedWaitMinutes;
  final String? recommendation;

  factory CafeteriaRecord.fromInput(
    String date,
    Map<String, dynamic> input,
  ) {
    validateDateKey(date);
    final operation = _mapValue(input['operation']);
    final congestion = _mapValue(input['congestion']);

    final menuName = _requiredString(input, 'menu_name', maxLength: 100);
    final items = _stringList(input['items'], maxItems: 20, maxLength: 100);
    final priceLabel = _optionalString(
          input['price_label'],
          maxLength: 50,
        ) ??
        '가격 확인 필요';
    final opensAt = _timeValue(operation['opens_at'], fallback: '11:30');
    final closesAt = _timeValue(operation['closes_at'], fallback: '13:30');
    final status = _congestionValue(congestion['status']);
    final waitMinutes = _waitMinutes(congestion['estimated_wait_minutes']);
    final recommendation = _optionalString(
      congestion['recommendation'],
      maxLength: 200,
    );

    return CafeteriaRecord(
      date: date,
      menuName: menuName,
      items: items,
      priceLabel: priceLabel,
      opensAt: opensAt,
      closesAt: closesAt,
      congestionStatus: status,
      estimatedWaitMinutes: waitMinutes,
      recommendation: recommendation,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'menu_name': menuName,
      'items': items,
      'price_label': priceLabel,
      'operation': {'opens_at': opensAt, 'closes_at': closesAt},
      'congestion': {
        if (congestionStatus != null) 'status': congestionStatus,
        if (estimatedWaitMinutes != null)
          'estimated_wait_minutes': estimatedWaitMinutes,
        if (recommendation != null) 'recommendation': recommendation,
      },
    };
  }

  static Map<String, dynamic> _mapValue(Object? value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return const <String, dynamic>{};
  }

  static String _requiredString(
    Map<String, dynamic> input,
    String key, {
    required int maxLength,
  }) {
    final value = _optionalString(input[key], maxLength: maxLength);
    if (value == null) {
      throw CafeteriaValidationException('$key is required');
    }
    return value;
  }

  static String? _optionalString(
    Object? value, {
    required int maxLength,
  }) {
    if (value == null) return null;
    if (value is! String) {
      throw const CafeteriaValidationException('Expected a string value');
    }
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    if (trimmed.length > maxLength) {
      throw CafeteriaValidationException(
        'String value exceeds $maxLength characters',
      );
    }
    return trimmed;
  }

  static List<String> _stringList(
    Object? value, {
    required int maxItems,
    required int maxLength,
  }) {
    if (value == null) return const [];
    if (value is! List) {
      throw const CafeteriaValidationException('items must be an array');
    }
    if (value.length > maxItems) {
      throw CafeteriaValidationException('items cannot exceed $maxItems');
    }

    return value
        .map(
          (item) => _optionalString(item, maxLength: maxLength),
        )
        .whereType<String>()
        .toList(growable: false);
  }

  static String _timeValue(Object? value, {required String fallback}) {
    final time = _optionalString(value, maxLength: 5) ?? fallback;
    if (!RegExp(r'^(?:[01]\d|2[0-3]):[0-5]\d$').hasMatch(time)) {
      throw const CafeteriaValidationException('Time must use HH:mm');
    }
    return time;
  }

  static String? _congestionValue(Object? value) {
    final status = _optionalString(value, maxLength: 20);
    if (status == null) return null;
    const supported = {
      'busy',
      'crowded',
      'normal',
      'moderate',
      'quiet',
      'available',
      'closed',
      'preparing',
      '혼잡',
      '보통',
      '여유',
      '준비 중',
    };
    if (!supported.contains(status.toLowerCase())) {
      throw const CafeteriaValidationException(
        'Unsupported congestion status',
      );
    }
    return status;
  }

  static int? _waitMinutes(Object? value) {
    if (value == null) return null;
    final minutes = switch (value) {
      int number => number,
      num number => number.toInt(),
      _ => int.tryParse(value.toString()),
    };
    if (minutes == null || minutes < 0 || minutes > 120) {
      throw const CafeteriaValidationException(
        'estimated_wait_minutes must be between 0 and 120',
      );
    }
    return minutes;
  }
}

abstract class CafeteriaStore {
  Future<CafeteriaRecord?> findByDate(String date);

  Future<void> put(CafeteriaRecord record);
}

class FileCafeteriaStore implements CafeteriaStore {
  FileCafeteriaStore._(this.file, this._records);

  final File file;
  final Map<String, CafeteriaRecord> _records;
  Future<void> _writeQueue = Future<void>.value();

  static Future<FileCafeteriaStore> open(String path) async {
    final file = File(path);
    final records = <String, CafeteriaRecord>{};

    if (await file.exists()) {
      final contents = await file.readAsString();
      if (contents.trim().isNotEmpty) {
        final decoded = jsonDecode(contents);
        if (decoded is! Map) {
          throw const FormatException('Cafeteria data file must be an object');
        }
        for (final entry in decoded.entries) {
          final date = entry.key.toString();
          final value = entry.value;
          if (value is! Map) {
            throw FormatException('Invalid cafeteria record for $date');
          }
          records[date] = CafeteriaRecord.fromInput(
            date,
            Map<String, dynamic>.from(value),
          );
        }
      }
    }

    return FileCafeteriaStore._(file, records);
  }

  @override
  Future<CafeteriaRecord?> findByDate(String date) async {
    validateDateKey(date);
    return _records[date];
  }

  @override
  Future<void> put(CafeteriaRecord record) {
    _records[record.date] = record;
    _writeQueue = _writeQueue.then((_) => _persist());
    return _writeQueue;
  }

  Future<void> _persist() async {
    await file.parent.create(recursive: true);
    final encoded = const JsonEncoder.withIndent('  ').convert(
      _records.map((date, record) => MapEntry(date, record.toJson())),
    );
    final temporary = File('${file.path}.tmp');
    await temporary.writeAsString('$encoded\n', flush: true);
    try {
      await temporary.rename(file.path);
    } on FileSystemException {
      if (await file.exists()) await file.delete();
      await temporary.rename(file.path);
    }
  }
}

class CafeteriaValidationException implements Exception {
  const CafeteriaValidationException(this.message);

  final String message;

  @override
  String toString() => 'CafeteriaValidationException: $message';
}

void validateDateKey(String date) {
  final match = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(date);
  if (match == null) {
    throw const CafeteriaValidationException('Date must use YYYY-MM-DD');
  }

  final year = int.parse(match.group(1)!);
  final month = int.parse(match.group(2)!);
  final day = int.parse(match.group(3)!);
  final parsed = DateTime.tryParse(date);
  if (parsed == null ||
      parsed.year != year ||
      parsed.month != month ||
      parsed.day != day) {
    throw const CafeteriaValidationException('Date is not valid');
  }
}
