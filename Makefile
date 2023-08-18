infra:
	docker-compose up -d
app:
	@curl --request POST --header "X-Vault-Token: $(ROOTPASSWORD)" --data '{"policies": "default","secret_id_ttl": "10h","token_num_uses": 10,"token_ttl": "20m","token_max_ttl": "30m"}' http://127.0.0.1:8200/v1/auth/approle/role/app
	ROLE_ID=$$(curl --request GET --header "X-Vault-Token: $(ROOTPASSWORD)" -s http://127.0.0.1:8200/v1/auth/approle/role/app/role-id | jq -r '.data.role_id'); \
	SECRET_ID=$$(curl --request POST --header "X-Vault-Token: $(ROOTPASSWORD)" -s http://127.0.0.1:8200/v1/auth/approle/role/app/secret-id | jq -r '.data.secret_id'); \
	echo "Secret ID: $$SECRET_ID and ROLE ID : $$ROLE_ID"; \
	curl --request POST --header "X-Vault-Token: $(ROOTPASSWORD)" --data "{'role_id': '$$ROLE_ID','secret_id':'$$SECRET_ID'}" http://127.0.0.1:8200/v1/auth/approle/login
build:
	docker-compose build

clean:
	docker-compose down
hello:
	@echo "Hello Word";
	@echo $(ROOTPASSWORD);
	
