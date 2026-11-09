#!/usr/bin/env bash
set -euo pipefail

ELASTICSEARCH_URL="${ELASTICSEARCH_URL:-http://localhost:9200}"
KIBANA_URL="${KIBANA_URL:-http://localhost:5601}"

curl --fail --silent --show-error "${ELASTICSEARCH_URL}/_cluster/health?pretty"
curl --fail --silent --show-error "${KIBANA_URL}/api/status" >/dev/null

echo "Elasticsearch and Kibana are available."
