# Reliability Checklist — FIT4110 Lab 03
# Nhóm A3 — team-gate (Access Gate)

Điền checklist này trước khi nộp Lab 03.

## 1. Functional tests

- [x] Có test cho endpoint health (`GET /health`).
- [x] Có test happy path cho endpoint chính: `POST /api/v1/gates/{gateId}/command` (OPEN, CLOSE).
- [x] Có test happy path: `POST /api/v1/access/verify` (direction IN và OUT).
- [x] Có kiểm tra status code 2xx.
- [x] Có kiểm tra field quan trọng trong response (`gateStatus`, `decision`, `logId`).
- [x] Có ít nhất 1 test đọc dữ liệu danh sách hoặc chi tiết.

## 2. Auth tests

- [x] Có test valid token được chấp nhận (TC06).
- [x] Có test thiếu token — skip trên mock, chạy trên local (TC07).
- [x] Có test sai token / token không hợp lệ — skip trên mock, chạy trên local (TC08).
- [x] Endpoint public (`/health`) được khai báo `security: []` trong contract.
- [x] Test thể hiện đúng expected status 401/403 trên local.
- [x] Không dùng `Prefer: code=401` để giả lập auth — test thật bằng cách bỏ/sai token.

## 3. Negative tests

- [x] Có test thiếu field bắt buộc `requestedBy` → 400/422 (TC09).
- [x] Có test sai enum `command=EXPLODE` → 400/422 (TC10).
- [x] Có test thiếu field bắt buộc `direction` → 400/422 (TC11).
- [x] Có test sai enum `direction=SIDEWAYS` → 400/422 (TC12).
- [x] Có test gateId không tồn tại → 4xx (TC13).
- [x] Lỗi trả về theo cùng một error model `ProblemDetails` (type, title, status, detail).

## 4. Boundary tests

- [x] Có test EMERGENCY_OPEN với reason (biên trên về lệnh khẩn) → 200 (TC14).
- [x] Có test EMERGENCY_OPEN không có reason — documented behavior (TC15).
- [x] Có test LOCKDOWN command → 200 gateStatus=LOCKED hoặc 409 (TC16).
- [x] Có test cardId dưới minLength (2 ký tự) → 400/422 (TC17).
- [x] Có ghi chú kỳ vọng xử lý dữ liệu biên trong test script.

## 5. Reliability tests cơ bản

- [x] Có test SLA response time < 300ms cho `/access/verify` (local only, TC19).
- [x] Có test response time < 500ms cho `/gates/{gateId}/command` (local only, TC20).
- [x] Có mô tả timeout: Access Gate set timeout 500ms, Fail-Closed nếu Core không phản hồi.
- [x] Idempotency ghi chú: OPEN/CLOSE là idempotent về mặt nghiệp vụ, EMERGENCY_OPEN không idempotent.
- [x] Có consumer-side smoke test: Access Gate gọi mock Core Business `/api/v1/access/verify` (TC18).

## 6. Evidence

- [x] Contract file: `contracts/gate.openapi.yaml`.
- [x] Collection export JSON: `postman/collections/FIT4110_lab03_gate.postman_collection.json`.
- [x] Environment mock export JSON: `postman/environments/FIT4110_lab03_gate_mock.postman_environment.json`.
- [x] Environment local export JSON: `postman/environments/FIT4110_lab03_gate_local.postman_environment.json`.
- [ ] Newman report XML/HTML: cần chạy `npm run test:mock` để sinh `reports/`.
- [x] Test-case matrix đã điền: `templates/test-case-matrix.csv` (20 test cases).
- [x] Biên bản handshake đã điền: `templates/consumer-provider-handshake.md`.
