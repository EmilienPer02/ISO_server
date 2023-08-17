infra:
	docker-compose up -f infra.yml
app:
	docker-compose up
build:
	docker-compose build

clean:
	docker-compose down
hello:
	@echo "Hello Word";
	@echo $(SEED);
	
