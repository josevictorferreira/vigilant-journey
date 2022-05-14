app_name = vigilant-journey
container_number = 1
container_name = $(app_name)
run_command = docker exec -it $(container_name)

up:
	docker-compose up

deps:
	docker-compose up -d database

build:
	docker-compose build

up_d:
	docker-compose up -d

logs:
	docker logs $(container_name) -f

sh:
	$(run_command) /bin/sh

bash:
	$(run_command) /bin/bash

console:
	$(run_command) rails console

setup_db:
	$(run_command) rails db:create db:migrate db:seed

setup_app:
	cp -rf .env-sample .env
	make up_d
	make setup_db
