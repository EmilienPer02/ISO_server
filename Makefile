infra:
	docker-compose up -d
app:
	@curl --request POST --header "X-Vault-Token: $(ROOTPASSWORD)" --data '{"policies": "default","secret_id_ttl": "10h","token_num_uses": 10,"token_ttl": "20m","token_max_ttl": "30m"}' http://127.0.0.1:8200/v1/auth/approle/role/postgres \
	curl --request POST --header "X-Vault-Token: $(ROOTPASSWORD)" --data '{"policies": "default","secret_id_ttl": "10h","token_num_uses": 10,"token_ttl": "20m","token_max_ttl": "30m"}' http://127.0.0.1:8200/v1/auth/approle/role/sonarqube
	POSTGRES_ROLE_ID=$$(curl --request GET --header "X-Vault-Token: $(ROOTPASSWORD)" -s http://127.0.0.1:8200/v1/auth/approle/role/postgres/role-id | jq -r '.data.role_id'); \
	POSTGRES_SECRET_ID=$$(curl --request POST --header "X-Vault-Token: $(ROOTPASSWORD)" -s http://127.0.0.1:8200/v1/auth/approle/role/postgres/secret-id | jq -r '.data.secret_id'); \
	SONARQUBE_ROLE_ID=$$(curl --request GET --header "X-Vault-Token: $(ROOTPASSWORD)" -s http://127.0.0.1:8200/v1/auth/approle/role/sonarqube/role-id | jq -r '.data.role_id'); \
	SONARQUBE_SECRET_ID=$$(curl --request POST --header "X-Vault-Token: $(ROOTPASSWORD)" -s http://127.0.0.1:8200/v1/auth/approle/role/sonarqube/secret-id | jq -r '.data.secret_id'); \
	curl --request POST --header "X-Vault-Token: $(ROOTPASSWORD)" --data '{"role_id": "'"$$POSTGRES_ROLE_ID"'","secret_id": "'"$$POSTGRES_SECRET_ID"'"}' http://127.0.0.1:8200/v1/auth/approle/login \ 
build:
	docker-compose build

clean:
	docker-compose down
	
