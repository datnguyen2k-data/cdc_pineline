curl http://localhost:8083/connectors

curl -X DELETE http://localhost:8083/connectors/test-db-connector

"f3-pancake-contact.json","chando-pancake-contact.json","menard-pancake-contact.json","postgres-jdbc-sale-order-source","labhair-pancake-contact.json"

curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @test-db-connector.json

curl http://localhost:8083/connectors/test-db-connector/status
