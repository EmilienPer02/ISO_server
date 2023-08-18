infra:
	docker-compose up -d
app:
	curl --header "X-Vault-Token: $(ROOTPASSWORD)" --request POST http://127.0.0.1:8200/v1/auth/token/create/app
build:
	docker-compose build

clean:
	docker-compose down
hello:
	@echo "Hello Word";
	@echo $(ROOTPASSWORD);
	
