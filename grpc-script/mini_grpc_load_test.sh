#!/bin/bash
# ---------------------------------------------
# Affirm gRPC Load Test Script
# ---------------------------------------------
# Description:
#   Continuously calls a gRPC endpoint using grpcurl
#   with detailed logging and configurable duration/concurrency.
#
# Usage:
#   ./grpc_load_test.sh [duration_seconds] [num_parallel]
#   Example: ./grpc_load_test.sh 600 4
#
# ---------------------------------------------

# Configurable parameters
DURATION=${1:-600}         # default: 10 minutes
PARALLEL=${2:-4}           # default: 4 concurrent clients
LOG_FILE="grpc_load_$(date +%Y%m%d_%H%M%S).log"

# gRPC target & options
PROTO_FILE="example.proto"
HOST="test-kotlin-dt-grpc.stage.aff"
SERVICE_METHOD="affirm.test.grpc.v1.GrpcExampleService/GetExampleEndpoint"
CERT_PATH="/nail/var/boba-pki-cert.pem"
KEY_PATH="/nail/var/boba-pki-key.pem"
TARGET="test-kotlin-dt-grpc.stage.aff:443"

echo "---------------------------------------------"
echo "🚀 Starting gRPC Load Test"
echo "Target: $TARGET"
echo "Host Header: $HOST"
echo "Duration: $DURATION seconds"
echo "Parallel Clients: $PARALLEL"
echo "Logging to: $LOG_FILE"
echo "---------------------------------------------"
echo ""

# Function to run a single load thread
load_runner() {
  local id=$1
  local end_time=$((SECONDS + DURATION))
  local count=0
  local success=0
  local fail=0

  while [ $SECONDS -lt $end_time ]; do
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    if grpcurl -proto "$PROTO_FILE" -d "" -insecure \
        -H "Host: $HOST" \
        -H 'content-type: application/grpc' \
        -cert "$CERT_PATH" \
        -key "$KEY_PATH" \
        "$TARGET" "$SERVICE_METHOD" >/dev/null 2>&1; then
      echo "[$timestamp] [Thread $id] ✅ Success (req $count)" >> "$LOG_FILE"
      ((success++))
    else
      echo "[$timestamp] [Thread $id] ❌ Failure (req $count)" >> "$LOG_FILE"
      ((fail++))
    fi
    ((count++))

    # Optional small sleep to control QPS
    sleep 0.05
  done

  echo "[$(date +"%Y-%m-%d %H:%M:%S")] [Thread $id] Finished - Total: $count, Success: $success, Fail: $fail" >> "$LOG_FILE"
}

# Launch threads
for ((i=1; i<=PARALLEL; i++)); do
  load_runner "$i" &
done

wait
echo ""
echo "✅ Load test completed! Logs saved to: $LOG_FILE"
