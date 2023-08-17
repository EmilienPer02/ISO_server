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
	echo $RANDOM | md5sum | head -c 20; echo;
