curl http://localhost:8083/connectors

curl -X DELETE http://localhost:8083/connectors/labhair-pancake-contact.json

"f3-pancake-contact.json","chando-pancake-contact.json","menard-pancake-contact.json","postgres-jdbc-sale-order-source","labhair-pancake-contact.json"

curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @labhair-pancake-contact.json

curl http://localhost:8083/connectors/chando-pancake-crm-contact/status
