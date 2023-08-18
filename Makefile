infra:
	docker-compose up -d
app:
	apt-get install jq
	curl --request POST --header "X-Vault-Token: $(ROOTPASSWORD)" --data '{"policies": "default","secret_id_ttl": "10h","token_num_uses": 10,"token_ttl": "20m","token_max_ttl": "30m"}' http://127.0.0.1:8200/v1/auth/approle/role/app
	curl --request POST --header "X-Vault-Token: $(ROOTPASSWORD)" http://127.0.0.1:8200/v1/auth/approle/role/app/secret-id > secret-id.txt
	@SECRET_ID=$$(cat secret-id.txt)
	@echo "Secret ID: $$SECRET_ID"
	#curl --request POST --header "X-Vault-Token: $(ROOTPASSWORD)" --data '{"role_name": "app"}' http://127.0.0.1:8200/v1/auth/approle/login
build:
	docker-compose build

clean:
	docker-compose down
hello:
	@echo "Hello Word";
	@echo $(ROOTPASSWORD);
	
