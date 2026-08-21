# Cafeteria API Contract

Paejae Pick reads the cafeteria API only when `PAEJAE_PICK_API_BASE_URL` is
provided at build or run time. If the variable is missing, the request times
out, or the response is invalid, the app keeps working with labeled sample
data.

## Run with an API

```bash
flutter run \
  --dart-define=PAEJAE_PICK_API_BASE_URL=https://api.example.com
```

The app requests:

```http
GET /v1/cafeteria/today?date=2026-08-21
Accept: application/json
```

## Response

```json
{
  "date": "2026-08-21",
  "menu_name": "제육덮밥",
  "items": ["제육볶음", "쌀밥", "된장국"],
  "price_label": "5,500원",
  "operation": {
    "opens_at": "11:30",
    "closes_at": "13:30"
  },
  "congestion": {
    "status": "normal",
    "estimated_wait_minutes": 6,
    "recommendation": "지금 방문 가능"
  }
}
```

Required fields are `date` and `menu_name`. Supported congestion values are
`busy`, `normal`, `quiet`, `closed`, and their Korean equivalents.

## Safety boundary

- The API base URL is configuration, not a secret.
- The mobile client does not store student identity or cafeteria history.
- Failed remote calls never block the cafeteria screen.
- Sample data is visibly labeled so it cannot be mistaken for official data.
