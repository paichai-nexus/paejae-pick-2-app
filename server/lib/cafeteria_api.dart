import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'admin_console.dart';
import 'cafeteria_store.dart';

class CafeteriaApi {
  CafeteriaApi({
    required this.store,
    required this.adminKey,
    this.allowedOrigin = '*',
  }) {
    if (adminKey.length < 24) {
      throw ArgumentError.value(
        adminKey.length,
        'adminKey',
        'Admin key must be at least 24 characters',
      );
    }
  }

  static const maxRequestBytes = 32 * 1024;

  final CafeteriaStore store;
  final String adminKey;
  final String allowedOrigin;

  Handler get handler {
    final router = Router()
      ..get('/admin', _adminConsole)
      ..get('/admin/assets/console.css', _adminConsoleCss)
      ..get('/admin/assets/console.js', _adminConsoleJavaScript)
      ..get('/health', _health)
      ..get('/v1/cafeteria/today', _getToday)
      ..put('/v1/admin/cafeteria/<date>', _putMenu);

    return _cors(router.call);
  }

  Response _adminConsole(Request request) {
    return _consoleResponse(
      adminConsoleHtml,
      'text/html; charset=utf-8',
      contentSecurityPolicy: true,
    );
  }

  Response _adminConsoleCss(Request request) {
    return _consoleResponse(adminConsoleCss, 'text/css; charset=utf-8');
  }

  Response _adminConsoleJavaScript(Request request) {
    return _consoleResponse(
      adminConsoleJavaScript,
      'text/javascript; charset=utf-8',
    );
  }

  Response _health(Request request) {
    return _jsonResponse({
      'status': 'ok',
      'service': 'paejae-pick-cafeteria-api',
    });
  }

  Future<Response> _getToday(Request request) async {
    final date = request.url.queryParameters['date'];
    if (date == null) {
      return _errorResponse(400, 'date query parameter is required');
    }

    try {
      validateDateKey(date);
      final record = await store.findByDate(date);
      if (record == null) {
        return _errorResponse(404, 'cafeteria menu not found');
      }
      return _jsonResponse(
        record.toJson(),
        headers: const {'cache-control': 'public, max-age=60'},
      );
    } on CafeteriaValidationException catch (error) {
      return _errorResponse(400, error.message);
    }
  }

  Future<Response> _putMenu(Request request, String date) async {
    final suppliedKey = request.headers['x-admin-key'] ?? '';
    if (!_constantTimeEquals(suppliedKey, adminKey)) {
      return _errorResponse(401, 'invalid administrator credential');
    }
    if (request.mimeType != 'application/json') {
      return _errorResponse(415, 'content-type must be application/json');
    }

    try {
      final body = await _readBody(request, maxRequestBytes);
      final decoded = jsonDecode(body);
      if (decoded is! Map) {
        return _errorResponse(400, 'request body must be a JSON object');
      }

      final record = CafeteriaRecord.fromInput(
        date,
        Map<String, dynamic>.from(decoded),
      );
      await store.put(record);
      return _jsonResponse(
        record.toJson(),
        headers: const {'cache-control': 'no-store'},
      );
    } on PayloadTooLargeException {
      return _errorResponse(413, 'request body is too large');
    } on FormatException {
      return _errorResponse(400, 'request body is not valid JSON');
    } on CafeteriaValidationException catch (error) {
      return _errorResponse(400, error.message);
    } catch (_) {
      return _errorResponse(500, 'unable to save cafeteria menu');
    }
  }

  Handler _cors(Handler inner) {
    return (request) async {
      const allowedHeaders = 'content-type,x-admin-key';
      const allowedMethods = 'GET,PUT,OPTIONS';
      final corsHeaders = {
        'access-control-allow-origin': allowedOrigin,
        'access-control-allow-headers': allowedHeaders,
        'access-control-allow-methods': allowedMethods,
        'vary': 'origin',
      };

      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: corsHeaders);
      }

      final response = await inner(request);
      return response.change(headers: {...response.headers, ...corsHeaders});
    };
  }
}

Response _consoleResponse(
  String body,
  String contentType, {
  bool contentSecurityPolicy = false,
}) {
  return Response.ok(
    body,
    headers: {
      'content-type': contentType,
      'cache-control': 'no-store',
      'x-content-type-options': 'nosniff',
      'x-frame-options': 'DENY',
      'referrer-policy': 'no-referrer',
      if (contentSecurityPolicy)
        'content-security-policy':
            "default-src 'self'; script-src 'self'; style-src 'self'; "
            "img-src 'self' data:; connect-src 'self'; frame-ancestors 'none'; "
            "base-uri 'none'; form-action 'self'",
    },
  );
}

Response _jsonResponse(
  Object body, {
  int statusCode = 200,
  Map<String, String> headers = const {},
}) {
  return Response(
    statusCode,
    body: jsonEncode(body),
    headers: {'content-type': 'application/json; charset=utf-8', ...headers},
  );
}

Response _errorResponse(int statusCode, String message) {
  return _jsonResponse(
    {'error': message},
    statusCode: statusCode,
    headers: const {'cache-control': 'no-store'},
  );
}

Future<String> _readBody(Request request, int maxBytes) async {
  final bytes = <int>[];
  await for (final chunk in request.read()) {
    if (bytes.length + chunk.length > maxBytes) {
      throw const PayloadTooLargeException();
    }
    bytes.addAll(chunk);
  }
  return utf8.decode(bytes);
}

bool _constantTimeEquals(String left, String right) {
  final leftBytes = utf8.encode(left);
  final rightBytes = utf8.encode(right);
  var difference = leftBytes.length ^ rightBytes.length;
  final length = leftBytes.length > rightBytes.length
      ? leftBytes.length
      : rightBytes.length;

  for (var index = 0; index < length; index++) {
    final leftByte = index < leftBytes.length ? leftBytes[index] : 0;
    final rightByte = index < rightBytes.length ? rightBytes[index] : 0;
    difference |= leftByte ^ rightByte;
  }
  return difference == 0;
}

class PayloadTooLargeException implements Exception {
  const PayloadTooLargeException();
}
