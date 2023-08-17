infra:
	docker-compose up -d
app:
	docker-compose up
build:
	docker-compose build

clean:
	docker-compose down
hello:
	@echo "Hello Word";
	@echo $(SEED);
	
