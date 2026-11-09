# Kibana Observability Lab

A reproducible local observability lab built with Elasticsearch and Kibana. The project demonstrates Elastic Stack deployment, structured log ingestion, index lifecycle concepts, data validation, and dashboard-oriented analysis without exposing production data or credentials.

## What this project demonstrates

- Elasticsearch and Kibana deployment with Docker Compose
- Version-pinned Elastic Stack services
- Health checks and persistent volumes
- Structured NGINX access-log ingestion through the Elasticsearch Bulk API
- A reusable index template for observability data
- Verification scripts for service availability and indexed documents
- Security guidance for adapting the lab to production environments

## Architecture

```text
Sample NGINX logs
       |
       v
Elasticsearch index: nginx-access-*
       |
       v
Kibana data view and dashboards
```

## Prerequisites

- Docker Engine 24+ with Docker Compose
- At least 4 GB of memory available to Docker
- `curl`

## Quick start

1. Start Elasticsearch and Kibana:

   ```bash
   docker compose up -d
   ```

2. Wait for the services and validate the stack:

   ```bash
   ./scripts/verify-stack.sh
   ```

3. Load the sanitized sample data:

   ```bash
   ./scripts/load-sample-data.sh
   ```

4. Open Kibana at [http://localhost:5601](http://localhost:5601).

5. Create a data view using `nginx-access-*` and select `@timestamp` as the time field.

## Suggested dashboard panels

- Requests over time
- HTTP status-code distribution
- Top requested paths
- Average response time
- Client distribution by fictitious IP address
- Error-rate trend for HTTP 4xx and 5xx responses

## Repository structure

```text
.
├── config/
│   ├── elasticsearch.yml
│   └── kibana.yml
├── sample-data/
│   └── nginx-access.ndjson
├── scripts/
│   ├── load-sample-data.sh
│   └── verify-stack.sh
└── docker-compose.yml
```

## Security notes

This repository is a local learning environment. Authentication and TLS are intentionally disabled to keep the lab reproducible on a developer workstation. Never expose these services to the internet with this configuration.

For production environments:

- enable Elastic security and TLS;
- store credentials in a secret manager;
- restrict network access;
- configure snapshots and retention policies;
- monitor cluster health and capacity;
- use matching Elasticsearch and Kibana versions.

## Portfolio context

This lab showcases practical experience with Kibana, Elasticsearch, observability, log analysis, Docker Compose, structured data ingestion, and operational documentation. All sample values are fictitious and contain no customer or government data.

## References

- [Kibana documentation](https://www.elastic.co/docs/products/kibana)
- [Install Kibana with Docker](https://www.elastic.co/docs/deploy-manage/deploy/self-managed/install-kibana-with-docker)
