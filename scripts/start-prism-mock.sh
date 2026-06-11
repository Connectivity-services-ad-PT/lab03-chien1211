#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-iot}"

case "${MODE}" in
  iot)
    npx prism mock contracts/iot-ingestion.openapi.yaml -p 4010 --host 0.0.0.0
    ;;
  gate)
    npx prism mock contracts/gate.openapi.yaml -p 4010 --host 0.0.0.0 &
    echo "Gate mock started on port 4010"
    ;;
  vision)
    npx prism mock contracts/ai-vision.openapi.yaml -p 4011 --host 0.0.0.0 &
    echo "AI Vision mock started on port 4011"
    ;;
  all)
    npm run mock:gate &
    GATE_PID=$!
    npm run mock:vision &
    VISION_PID=$!
    trap 'kill ${GATE_PID} ${VISION_PID} 2>/dev/null || true' EXIT
    echo "Mock servers for Gate and AI Vision started."
    wait
    ;;
  *)
    echo "Usage: scripts/start-prism-mock.sh [iot|vision|all]"
    exit 1
    ;;
esac
