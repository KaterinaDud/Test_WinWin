.PHONY: up down logs test

up:
	docker compose up -d --build
	@echo "Waiting for services to be healthy..." 

down:
	@echo "Stopping services..."
	docker compose down -v
	@echo "Services stopped."

logs:
	@echo "Tailing logs..."
	docker compose logs -f --tail=200

test:
	@curl -s http://localhost:8080/healthz | jq .
	@echo "Flood test (expect some 429s):"
	@for i in `seq 1 20`; do curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8080/; done | sort | uniq -c
