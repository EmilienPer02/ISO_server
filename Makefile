infra:
	docker-compose up -d
app:
	curl --header "X-Vault-Token: $(ROOTPASSWORD)" --request POST --data "@templates/app_role.json" http://127.0.0.1:8200/v1/auth/approle/role/application1
build:
	docker-compose build

clean:
	docker-compose down
hello:
	@echo "Hello Word";
	@echo $(ROOTPASSWORD);
	
