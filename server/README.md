# Paejae Pick Cafeteria API

Small Dart/Shelf API used to validate the Paejae Pick cafeteria flow before a
university-operated backend is available.

## Start

```bash
cd server
dart pub get
PAEJAE_PICK_ADMIN_API_KEY='replace-with-at-least-24-characters' \
  dart run bin/server.dart
```

Optional environment variables:

- `PORT`: HTTP port, default `8080`
- `PAEJAE_PICK_DATA_FILE`: JSON storage path, default
  `data/cafeteria_menus.json`
- `PAEJAE_PICK_ALLOWED_ORIGIN`: CORS origin, default `*`

Do not put the administrator key in the Flutter app, source control, screenshots,
or chat messages. Only the server process and authorized operators should know
it.

## Open the operator console

After starting the server, open:

```text
http://localhost:8080/admin
```

The console can load an existing menu, preview changes, and update the menu and
congestion state. The administrator key stays in the password field only for
the current page session; the console does not write it to browser storage.

Use HTTPS for every non-local deployment. This console is an internal MVP, not
a replacement for university identity, audit-log, or role-based access systems.

## Register a menu

```bash
curl --request PUT 'http://localhost:8080/v1/admin/cafeteria/2026-08-21' \
  --header 'content-type: application/json' \
  --header "x-admin-key: $PAEJAE_PICK_ADMIN_API_KEY" \
  --data @data/cafeteria_menu_request.example.json
```

## Read a menu

```bash
curl 'http://localhost:8080/v1/cafeteria/today?date=2026-08-21'
```

## Test

```bash
dart analyze --fatal-infos
dart test
```
