#!/usr/bin/env bash
set -euo pipefail

ELASTICSEARCH_URL="${ELASTICSEARCH_URL:-http://localhost:9200}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

curl --fail --silent --show-error \
  -X PUT "${ELASTICSEARCH_URL}/_index_template/nginx-access-template" \
  -H 'Content-Type: application/json' \
  -d '{
    "index_patterns": ["nginx-access-*"],
    "template": {
      "mappings": {
        "properties": {
          "@timestamp": {"type": "date"},
          "client_ip": {"type": "ip"},
          "method": {"type": "keyword"},
          "path": {"type": "keyword"},
          "status": {"type": "integer"},
          "response_time_ms": {"type": "integer"},
          "bytes": {"type": "long"}
        }
      }
    }
  }' >/dev/null

curl --fail --silent --show-error \
  -X POST "${ELASTICSEARCH_URL}/_bulk?refresh=true" \
  -H 'Content-Type: application/x-ndjson' \
  --data-binary "@${PROJECT_DIR}/sample-data/nginx-access.ndjson" >/dev/null

echo "Sample data loaded successfully."
curl --fail --silent --show-error \
  "${ELASTICSEARCH_URL}/nginx-access-*/_count?pretty"
