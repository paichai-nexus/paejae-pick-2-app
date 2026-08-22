import 'dart:io';

import 'package:paejae_pick_cafeteria_api/cafeteria_api.dart';
import 'package:paejae_pick_cafeteria_api/cafeteria_store.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

Future<void> main() async {
  final environment = Platform.environment;
  final adminKey = environment['PAEJAE_PICK_ADMIN_API_KEY'] ?? '';
  if (adminKey.length < 24) {
    stderr.writeln(
      'PAEJAE_PICK_ADMIN_API_KEY must contain at least 24 characters.',
    );
    exitCode = 64;
    return;
  }

  final port = int.tryParse(environment['PORT'] ?? '8080');
  if (port == null || port < 1 || port > 65535) {
    stderr.writeln('PORT must be between 1 and 65535.');
    exitCode = 64;
    return;
  }

  final dataFile = environment['PAEJAE_PICK_DATA_FILE'] ??
      'data/cafeteria_menus.json';
  final allowedOrigin = environment['PAEJAE_PICK_ALLOWED_ORIGIN'] ?? '*';
  final store = await FileCafeteriaStore.open(dataFile);
  final api = CafeteriaApi(
    store: store,
    adminKey: adminKey,
    allowedOrigin: allowedOrigin,
  );
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(api.handler);
  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, port);
  server.autoCompress = true;

  stdout.writeln(
    'Paejae Pick cafeteria API listening on port ${server.port}.',
  );
}
