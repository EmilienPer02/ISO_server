infra:
	docker-compose up -d
app:
	@curl --request POST --header "X-Vault-Token: $(ROOTPASSWORD)" --data '{"policies": "default","secret_id_ttl": "10h","token_num_uses": 10,"token_ttl": "20m","token_max_ttl": "30m"}' http://127.0.0.1:8200/v1/auth/approle/role/app
	ROLE_ID=$$(curl --request GET --header "X-Vault-Token: $(ROOTPASSWORD)" -s http://127.0.0.1:8200/v1/auth/approle/role/app/role-id | jq -r '.data.role_id'); \
	SECRET_ID=$$(curl --request POST --header "X-Vault-Token: $(ROOTPASSWORD)" -s http://127.0.0.1:8200/v1/auth/approle/role/app/secret-id | jq -r '.data.secret_id'); \
	docker-compose -f app.yml run -e ROLE_ID=$$ROLE_ID -e SECRET_ID=$$SECRET_ID 
build:
	docker-compose build

clean:
	docker-compose down
	
