infra:
	docker-compose up -d
app:
	curl --request POST --header "X-Vault-Token: $(ROOTPASSWORD)" --data '{"policies": "default","secret_id_ttl": "10h","token_num_uses": 10,"token_ttl": "20m","token_max_ttl": "30m"}' http://http://127.0.0.1:8200/v1/auth/approle/role/app
build:
	docker-compose build

clean:
	docker-compose down
hello:
	@echo "Hello Word";
	@echo $(ROOTPASSWORD);
	
