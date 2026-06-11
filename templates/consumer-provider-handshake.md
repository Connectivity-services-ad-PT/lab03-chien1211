# Consumer–Provider Handshake

## Thông tin chung

- Lab: FIT4110 Lab 03
- Ngày: 2026-05-13
- Provider team: team-core (nhóm A6 — Core Business)
- Consumer team: team-gate (nhóm A3 — Access Gate)
- Provider service: Core Business
- Consumer service: Access Gate

## Contract

- Contract file: `contracts/gate.openapi.yaml`
- Mock base URL: `http://localhost:4010` (mock) / `http://localhost:4012` (local)
- Auth method: Bearer Token (`Authorization: Bearer <token>`)
- Endpoint được test: `POST /api/v1/access/verify`

## Smoke test

### Request

```http
POST /api/v1/access/verify
Authorization: Bearer lab-token
Content-Type: application/json
```

```json
{
  "cardId": "CARD-NV-0042",
  "gateId": "GATE-A-01",
  "direction": "IN",
  "timestamp": "2026-05-13T08:30:00+07:00"
}
```

### Expected response

```json
{
  "decision": "GRANTED",
  "logId": "LOG-20260513-0001",
  "reason": null
}
```

## Kết quả

- [x] Consumer (Access Gate) gọi mock Core Business thành công — status 200.
- [x] Consumer parse được field `decision` (GRANTED/DENIED).
- [x] Consumer parse được field `logId` (string tham chiếu).
- [x] Consumer hiểu lỗi 4xx (ProblemDetails) khi Core trả 400/503.
- [ ] Có Newman report hoặc screenshot (cần chạy Newman để sinh evidence).

## Ghi chú thay đổi hợp đồng

| Nội dung | Trước | Sau | Người đồng ý |
|---|---|---|---|
| Thêm trường `direction` bắt buộc | Không có | `direction: enum [IN, OUT]` | A3 + A6 |
| Thêm SLA 300ms | Không quy định | Core cam kết < 300ms, Gate timeout 500ms | A3 + A6 |
| Thêm Fail-Closed khi Core timeout | Không quy định | Gate giữ đóng nếu không nhận response trong 500ms | A3 + A6 |

## Xác nhận

- Provider representative: Nhóm A6 (Core Business)
- Consumer representative: Nhóm A3 (Access Gate)
