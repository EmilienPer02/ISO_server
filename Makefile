infra:
	docker-compose up
app:
	docker-compose up
build:
	docker-compose build

clean:
	docker-compose down
hello:
	@echo "Hello Word";
	ROOT_PASSORD:=$(openssl rand -hex 8);
	echo $(ROOT_PASSORD);
