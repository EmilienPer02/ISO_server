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
	cat /dev/urandom | tr -dc '[:alpha:]' | fold -w ${1:-20} | head -n 1
