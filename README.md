curl http://localhost:8083/connectors

curl -X DELETE http://localhost:8083/connectors/test-db-connector

"f3-pancake-contact.json","chando-pancake-contact.json","menard-pancake-contact.json","postgres-jdbc-sale-order-source","labhair-pancake-contact.json"

curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @test-db-connector.json

curl http://localhost:8083/connectors/test-db-connector/status


curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @test-iceberg-sink-connection.json

curl http://localhost:8083/connectors/test-iceberg-sink-connection/status

curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @s3-sink-sale-order.json

curl -X DELETE http://localhost:8083/connectors/s3-sink-sale-order

curl http://localhost:8083/connectors/s3-sink-sale-order/status
