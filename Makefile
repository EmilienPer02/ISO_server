infra:
	docker-compose up
app:
	docker-compose up
build:
	docker-compose build

clean:
	docker-compose down
hello:
	@echo "Hello Word"
	rand=$$RANDOM && \
	echo $rand;
