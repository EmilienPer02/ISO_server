infra:
	docker-compose up

app:
  docker-compose up
build:
	docker-compose -f app.yml build

clean:
	docker-compose down
	docker-compose -f app.yml down
